##################################################################################
# PROVIDERS
##################################################################################

provider "aws" {
  region     = "${var.region}"
}

##################################################################################
# RESOURCES
##################################################################################

resource "aws_security_group" "default" {
	name = "tomcat_sg"
	description = "this is a security group for creating a tomcat_deploy instance"
	
ingress {

	 from_port = "22"
	 to_port = "22"
	 protocol = "tcp"
	 cidr_blocks = "${var.my_cidr_blocks}"
	
	}

ingress {

	 from_port = "8080"
	 to_port = "8080"
	 protocol = "tcp"
	 cidr_blocks = "${var.my_cidr_blocks}"
	}

egress {
	
   from_port = "${var.my_pub_port}"
	 to_port = "${var.my_pub_port}"
	 protocol = "${var.my_pub_protocol}"
	 cidr_blocks = ["0.0.0.0/0"]
	}
	
	}
resource "aws_instance" "tomcat_deploy" {
 
  ami           = "${var.ami_type}"
  instance_type = "${var.instance_type}"
  key_name      = "${var.key_name}"

  security_groups = ["${aws_security_group.default.name}"]
  
  tags = {
    Name = "tomcat_autodeploy"
  }

provisioner "local-exec" {
    command = <<eof
     echo ${aws_instance.tomcat_deploy.public_dns} > pub.txt
     export getpubdns=`cat ./pub.txt | tr -d ';' | sed 's/ *$//'`
     sleep 300
     curl -s -o Calendar.war "https://bintray.com/sirinik05/CalendarApp/mycalendar"
     curl "http://admin:admin@$getpubdns:8080/manager/text/undeploy?path=/Cal2"
     curl --upload-file ./Calendar.war "http://admin:admin@$getpubdns:8080/manager/text/deploy?path=/Cal2"
    eof
}

}
