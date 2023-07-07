terraform {
  backend "s3" {
    bucket = "devops-directive-tf-state"
    key = "07-managing-multiple-environments/staging/terraform.tfstate"
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

variable "db_pass" {
  description = "password for database"
  type = string
  sensitive = true
}

locals {
  environment_name = "staging"
}

module "web_app" {
  source = "../../../06-Organization-and-modules/web-app-module"

  # Input Variables
  bucket_prefix = "web-app-data-${local.environment_name}"
  domain = "devopsdeployed.com"
  environment_name = local.environment_name
  instance_type = "t2.micro"
  create_dns_zone = false
  db_name = "${local.environment_name}mydb"
  db_user = "foo"
  db_pass = var.db_pass
}