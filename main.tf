provider "aws" {
    #access_key = "${var.access_key}"
    #secret_key ="${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "web_instance" {
    ami = "${var.instance_ami}"
    instance_type = "${var.instance_type}"
    tags= {

        Name="tf_web_instance"
    }
    
  
}

