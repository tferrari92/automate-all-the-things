
terraform {
  required_version = ">= 1.1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.27.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
  }

  backend "s3" {
    bucket         = "cafe-tf-state-bucket" # This value was modified by the initial-setup python script
    dynamodb_table = "cafe-tf-state-dynamo-db-table" # This value was modified by the initial-setup python script
    key            = "terraform.tfstate"
    region         = "us-east-2"
    encrypt        = true
  }
}



provider "aws" {
  # region = var.region

  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
}


# data "aws_eks_cluster_auth" "cluster" {
#   name = aws_eks_cluster.this.name
# }

# provider "helm" {

#   kubernetes {
#     config_path = "~/.kube/config"
#   }
#   # kubernetes {
#   #   host                   = output.cluster_endpoint
#   #   cluster_ca_certificate = output.cluster_ca_certificate
#   #   # cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
#   #   token                  = data.aws_eks_cluster_auth.cluster.token
#   #   }
# }

# provider "helm" {
#   kubernetes {
#     host                   = aws_eks_cluster.this.endpoint
#     cluster_ca_certificate = aws_eks_cluster.this.certificate_authority[0].data
#     # cluster_ca_certificate = base64decode(var.cluster_ca_cert)
#     exec {
#       api_version = "client.authentication.k8s.io/v1beta1"
#       args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.this.name]
#       command     = "aws"
#     }
#   }
# }