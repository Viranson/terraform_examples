provider "aws" {
  region     = "us-east-1"
  access_key = "AKIAV4P6D24Q7SNPVQYK"
  secret_key = "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"
}

terraform {
  backend "s3" {
    bucket     = "terraform-backend-etraining"
    key        = "terraform.prod.tfstate" # Nom du fichier tfstate à stocker dans le compartiment s3
    region     = "us-east-1"
    access_key = "AKIAV4P6D24Q7SNPVQYK"
    secret_key = "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"
  }
}


module "ec2" {
  source       = "../modules/ec2module"
  instancetype = "t2.micro"
  aws_common_tag = {
    Name = "ec2-prod-terraform"
  }
  security_group_name = "prod-terraform-sg"
}