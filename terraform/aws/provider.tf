
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.27.0"
    }
  }

  backend "s3" {
    bucket         = "cafe-tf-state-bucket" # This value was modified by the initial-setup python script
    dynamodb_table = "cafe-tf-state-dynamo-db-table" # This value was modified by the initial-setup python script
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}



provider "aws" {
  # region = var.region

  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
}
