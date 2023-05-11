
terraform {
  backend "s3" {
    bucket         = "AATT_APP_NAME-tf-state-bucket"
    dynamodb_table = "AATT_APP_NAME-tf-state-dynamo-db-table"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}
