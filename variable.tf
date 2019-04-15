variable "key_name" {
  default = "siriAWS.pub"
}

variable "private_key_path" {
  default = "/opt/key/siriAWS"
}

variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "ami_type" {
  default = "ami-03b5146883373319b"
}

variable "my_default_port" {
  default = "22"
}

variable "my_cidr_blocks" {
  default = ["69.119.126.1/32"]
}

variable "my_pub_port" {
  default = "0"
}

variable "my_pub_protocol" {
  default = "-1"
}

variable "my_tom_port" {
  default = "8080"
}

variable "my_protocol" {
  default = "tcp"
}
