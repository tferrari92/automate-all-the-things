
terraform {
  backend "s3" {
    bucket         = "aatt-tf-state"
    dynamodb_table = "terraform-state-locking"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}
provider "aws" {
  region = var.region

  access_key = var.aws_access_key
  secret_key = var.aws_secret_key

  # other options for authentication
}