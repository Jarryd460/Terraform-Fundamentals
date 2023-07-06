terraform {
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

locals {
  extra_tag = "extra_tag"
}

resource "aws_instance" "instance" {
  ami = var.ami
  instance_type = var.instance_name

  tags = {
    Name = var.instance_name
    ExtraTag = local.extra_tag
  }
}

resource "aws_db_instance" "db_instance" {
  allocated_storage = 20
  storage_type = "gp2"
  engine = "postgres"
  engine_version = "12.4"
  instance_class = "db.t2.micro"
  name = "mvdb"
  # To pass the username and password because they have not been given values in terraform.tfvars, you
  # can run terraform apply -var="db_user=myuser" -var="db_pass=mypasswordsecured"
  username = var.db_user
  password = var.db_pass
  skip_final_snapshot = true
}