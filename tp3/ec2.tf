provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAV4P6D24Q7SNPVQYK"
  secret_key = "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"
}

data "aws_ami" "app_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm*"]
  }
}

resource "aws_security_group" "allow_http_https" {
  name        = "allow_http_https"
  description = "Allow HTTP and HTTPS inbound traffic"

  ingress {
    description      = "TLS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_http_https"
  }
}

resource "aws_instance" "myec2" {
  ami             = data.aws_ami.app_ami.id
  instance_type   = var.instancetype
  key_name        = "devops-terraform"
  tags            = var.aws_common_tag
  security_groups = ["${aws_security_group.allow_http_https.id}"]


  # Pour forcer la suppression des blocs ebs créés pour les instances
  root_block_device {
    delete_on_termination = true
  }
}

resource "aws_eip" "myec2_eip" {
  instance = "$(aws_instance.myec2.id)"
  vpc      = true
}