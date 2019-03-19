provider "aws" {
    #access_key = "${var.access_key}"
    #secret_key ="${var.secret_key}"
    region = "${var.region}"
}

resource "aws_instance" "web_instance" {
    ami = "${var.instance_ami}"
    instance_type = "${var.instance_type}"
    vpc_security_group_ids= ["${aws_security_group.web_security_group.id}"]
    
    user_data= <<EOF
              #! /bin/bash
              echo "create a .ssh directory with right permissions"
              mkdir /home/ec2-user/.ssh && chmod 700 
              cat /home/ec2-user/.ssh/authorized_keys && chmod 600
              echo "${var.instance_public_key}" > /home/ec2-user/.ssh/authorized_keys

              yum install -y httpd 
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
        cidr_blocks = ["0.0.0.0/0"]
    }
     ingress={
        from_port=  22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}


output "public_ip" {
  value = "${aws_instance.web_instance.public_ip}"
}
