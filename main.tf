provider "aws" {
    #access_key = "${var.access_key}"
    #secret_key ="${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "web_instance" {
    ami = "${var.instance_ami}"
    instance_type = "${var.instance_type}"
    
    user_data= <<EOF
              #! /bin/bash
              yum install httpd -y
              echo "hello world" > /var/www/html/index.html
              EOF


    tags= {

        Name="tf_web_instance"
    }
    
  
}

resource "aws_security_group" "web_security_group" {
    name = "web_security_group"
    ingress={
        from_port=  80
        to_port = 80
        protocol = "tcp"
        CIDR_blocks = ["0.0.0.0/0"]
    }

}