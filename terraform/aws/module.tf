module "eks-kubeconfig" {
  source  = "hyperbadger/eks-kubeconfig/aws"
  version = "2.0.0"
  # insert the 1 required variable here
  cluster_name = "automate-all-the-things-cluster"

  depends_on = [
    aws_eks_cluster.this
  ]
}