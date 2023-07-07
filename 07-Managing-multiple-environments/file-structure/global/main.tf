terraform {
  backend "s3" {
    bucket = "devops-directive-tf-state"
    key = "07-Managing-multiple-environments/global/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "terraform-state-locking"
    encrypt = true
  }

  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~>4.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"    
}

resource "aws_route53_zone" "primary" {
  name = "devopsdeployed.com"
}