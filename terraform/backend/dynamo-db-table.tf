resource "aws_dynamodb_table" "terraform_locks" {
    name = "AATT_APP_NAME-tf-state-dynamo-db-table"
    billing_mode = "PAY_PER_REQUEST"
    hash_key = "LockID"
    attribute {
        name = "LockID"
        type = "S"
    }
}