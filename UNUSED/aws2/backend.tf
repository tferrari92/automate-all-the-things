
# terraform {
#   backend "s3" {
#     bucket         = "cafe-tf-state-bucket" # This value was modified by the initial-setup python script
#     dynamodb_table = "cafe-tf-state-dynamo-db-table" # This value was modified by the initial-setup python script
#     key            = "terraform.tfstate"
#     region         = "us-east-2"
#     encrypt        = true
#   }
# }

resource "aws_s3_bucket" "terraform_state" {
    bucket = "${var.project}-tf-state-bucket"
    force_destroy = true
    versioning {
        enabled = true
    }

    server_side_encryption_configuration {
        rule {
            apply_server_side_encryption_by_default {
                sse_algorithm = "AES256"
            }
        }
    }
}

resource "aws_dynamodb_table" "terraform_locks" {
    name = "${var.project}-tf-state-dynamo-db-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}