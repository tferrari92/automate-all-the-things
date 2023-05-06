
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
  region = var.region

  access_key = "AKIAVN4NL6WT46VOWGHJ"
  secret_key = "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"
}
