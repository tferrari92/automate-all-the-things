module "eks" {
    source = "terraform-aws-modules/eks/aws"
    version = "18.19.0"

    cluster_name                    = "${var.project}-cluster"
    cluster_version                 = "1.21"
    cluster_endpoint_private_access = true
    cluster_endpoint_public_access  = true
    cluster_additional_security_group_ids = [aws_security_group.eks.id]

    vpc_id     = aws_vpc.this.id
    subnet_ids = aws_subnet.private.id

    eks_managed_node_group_defaults = {
      ami_type               = "AL2_x86_64"
      disk_size              = 50
      instance_types         = ["t2.medium", "t2.large"]
      vpc_security_group_ids = [aws_security_group.eks.id]
    }

    eks_managed_node_groups = {
      green = {
        min_size     = 1
        max_size     = 3
        desired_size = 2

        instance_types = ["t2.medium"]
        capacity_type  = "SPOT"
        labels = var.tags 
        taints = {
        }
        tags = var.tags
      }
    }

    tags = var.tags
}



