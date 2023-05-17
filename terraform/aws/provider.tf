terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
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



# ----------------- AWS -----------------

provider "aws" {
   # region = var.region

  # access_key = var.aws_access_key
  # secret_key = var.aws_secret_key
}



# ----------------- Helm -----------------

data "aws_eks_cluster_auth" "default" {
  # name = aws_eks_cluster.cluster.cluster_id
  name = aws_eks_cluster.cluster.id
}

provider "helm" {
  kubernetes {
    host                   = aws_eks_cluster.cluster.endpoint
    cluster_ca_certificate = base64decode(aws_eks_cluster.cluster.certificate_authority[0].data)

    # Getting the token this way does not require to have aws cli installed! 
    token = data.aws_eks_cluster_auth.default.token

    # exec {
    #   api_version = "client.authentication.k8s.io/v1beta1"
    #   args        = ["eks", "get-token", "--cluster-name", aws_eks_cluster.cluster.id]
    #   command     = "aws"
    # }
  }
}