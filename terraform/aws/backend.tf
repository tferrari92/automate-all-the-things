
terraform {
  backend "s3" {
    bucket         = "${var.project}-tf-state-bucket"
    dynamodb_table = "${var.project}-tf-state-dynamo-db-table"
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}
