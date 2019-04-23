provider "aws" {
  access_key = "${lookup(var.access_key , var.cloud_env)}"
  secret_key = "${lookup(var.secret_key, var.cloud_env)}"
  region     = "${lookup(var.region, var.cloud_env)}"
}

resource "aws_vpc" "main_la" {
  cidr_block = "12.0.0.0/16"
  count = "${var.vpc_creation}"
}

resource "aws_subnet" "main_la" {
  vpc_id     = "${aws_vpc.main_la.id}"
  cidr_block = "12.0.1.0/24"
  count = "${var.vpc_creation}"
  tags = {
    Name = "Main_la"
  }
}


resource "aws_instance" "web_instance" {
  ami                    = "${var.instance_ami}"
  instance_type          = "${var.instance_type}"
  subnet_id = "${aws_subnet.main_la.id}"
  vpc_security_group_ids = ["${aws_security_group.web_security_group.id}"]

  user_data = <<EOF
             ! /bin/bash
              echo "create a .ssh directory with right permissions"
              mkdir /home/ec2-user/.ssh && chmod 700 
              cat /home/ec2-user/.ssh/authorized_keys && chmod 600
              echo "${var.instance_public_key}" > /home/ec2-user/.ssh/authorized_keys
              echo "${var.ansible_public_key}" >> /home/ec2-user/.ssh/authorized_keys

              yum install -y httpd --enablerepo=epel --disablerepo=* 
              echo "hello world" > /var/www/html/index.html
              EOF

  tags = {
    Name = "tf_web_instance"
  }
}

resource "aws_security_group" "web_security_group" {
  name = "web_security_group"
  vpc_id = "${aws_vpc.main_la.id}"

  ingress = {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress = {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "public_ip" {
  value = "${aws_instance.web_instance.public_ip}"
}
