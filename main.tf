provider "aws" {
    #access_key = "${var.access_key}"
    #secret_key ="${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "instance" {
    ami = "${var.instance_ami}"
    instance_type = "${var.instance_type}"
    
    
  
}


resource "aws_subnet" "public_subnet1" {
     availability_zone = "${var.public_subnet1}"
     cidr_block = "10.10.0.0/28"
}


resource "aws_security_group" "public_security_group" {
   ingress 
}


resource "aws_security_group" "public_security_group" {
   ingress 
}




