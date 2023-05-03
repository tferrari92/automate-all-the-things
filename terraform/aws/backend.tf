
# terraform {
#   backend "s3" {
#     bucket         = "<REPLACE_WITH_YOUR_REMOTESTATE_BUCKETNAME>"
#     dynamodb_table = "<REPLACE_WITH_YOUR_DYNAMODB_TABLENAME>"
#     key            = "terraform-aws-eks-workshop.tfstate"
#     region         = "us-east-2"
#     encrypt        = true
#   }
# }
