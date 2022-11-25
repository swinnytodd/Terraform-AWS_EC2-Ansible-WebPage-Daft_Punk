provider "aws" {
  region = "eu-west-1"
}

resource "aws_default_vpc" "default" {} # This need to be added since AWS Provider v4.29+ to get VPC id

resource "aws_instance" "my_server_web" {
  ami                    = "ami-01cae1550c0adea9c"
  instance_type          = "t2.micro"
  key_name               = "aws_key"
  vpc_security_group_ids = [aws_security_group.ansible.id]
  user_data       =        file("user_data.sh")

  tags = {
    Name = "Ansible-Test"
  }
}

output "public_ip" {
  value       = aws_instance.my_server_web
  description = "The public IP address of the web server"
}

resource "aws_security_group" "ansible" {
  name   = "Security Group Ansible"
  vpc_id = aws_default_vpc.default.id # This need to be added since AWS Provider v4.29+ to set VPC id


  dynamic "ingress" {
    for_each = ["80", "443", "22", "8080"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My SecurityGroup Ansible"
  }
}