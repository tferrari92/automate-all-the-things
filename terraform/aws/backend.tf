
terraform {
  backend "s3" {
    bucket         = "cafe-tf-state-bucket" # This value was modified by the initial-setup python script
    dynamodb_table = "cafe-tf-state-dynamo-db-table" # This value was modified by the initial-setup python script
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}
