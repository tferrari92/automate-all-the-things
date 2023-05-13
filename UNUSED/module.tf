module "eks-kubeconfig" {
  source  = "hyperbadger/eks-kubeconfig/aws"
  version = "2.0.0"

  cluster_name = "${var.project}-cluster"

  depends_on = [
    aws_eks_cluster.this
  ]
}

output "kubeconfig" {
  description = "Configure kubectl: make sure you're logged in with the correct AWS profile and run the following command to update your kubeconfig"
  value       = module.eks-kubeconfig.kubeconfig
  sensitive = true
}