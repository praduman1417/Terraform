provider "aws" {
    #access_key = "${var.access_key}"
    #secret_key ="${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "instance" {
    ami = "${var.instance_ami}"
    instance_type = "${var.instance_type}"
    
    
  
}

