
terraform {
  backend "s3" {
    bucket         = "aatt-tf-state"
    dynamodb_table = "terraform-state-locking"
    key            = "aa-tt.tfstate"
    region         = var.region
    encrypt        = true
  }
}
