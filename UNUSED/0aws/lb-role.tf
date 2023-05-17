# In order to install the load balancer controller you first need to grant access via an IAM role. Fortunatly there is a simple module for this
# This module will add an iam policy to the cluster to allow the creation of load balancers. 
# Remember the namespace_service_accounts line, it is assuming you are going to create a service account in the kube-system namespace called aws-load-balancer-controller. 
# Thats the default location that is used in the documentation. 
# If you need to use a different namespace or service account name then thats fine but remember to update this module.

module "lb_role" {
  source    = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"

  role_name = "${var.project}_eks_lb"
  attach_load_balancer_controller_policy = true

  oidc_providers = {
    main = {
    #   provider_arn               = module.eks.oidc_provider_arn
      provider_arn               = module.eks.oidc_provider_arn
      namespace_service_accounts = ["kube-system:aws-load-balancer-controller"]
    }
  }
}