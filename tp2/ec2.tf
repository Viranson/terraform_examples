provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAV4P6D24Q7SNPVQYK"
  secret_key = "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"
}


resource "aws_instance" "myec2" {
  ami           = "ami-0083662ba17882949"
  instance_type = var.instancetype
  key_name      = "terraform"
  tags = {
    Name = "ec2-terraform"
  }

# Pour forcer la suppression des blocs ebs créés pour les instances
  root_block_device {
    delete_on_termination = true
  }
}
