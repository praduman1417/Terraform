provider "aws" {
    access_key = "${var.access_key}"
    secret_key ="${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "instance" {
    ami = "ami-b70554c8"
    instance_type = "t2.micro"
    
  
}


resource "aws_subnet" "public_subnet" {
     

}


resource "aws_security_group" "public_security_group" {
  
}





