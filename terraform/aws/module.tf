module "eks-kubeconfig" {
  source  = "hyperbadger/eks-kubeconfig/aws"
  version = "2.0.0"

  cluster_name = "${var.project}-cluster"

  depends_on = [
    aws_eks_cluster.this
  ]
}