terraform {
  required_version = ">= 1.1.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.27.0"
    }
  }
}

provider "aws" {
  # region = var.region

  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
}