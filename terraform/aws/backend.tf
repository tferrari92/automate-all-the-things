
terraform {
  backend "s3" {
    bucket         = "aatt-tf-state"
    dynamodb_table = "terraform-state-locking"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}
