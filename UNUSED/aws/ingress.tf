
# resource "helm_release" "aws_load_balancer_controller" {
#   name       = "ingress"
#   chart      = "aws-load-balancer-controller"
#   repository = "https://aws.github.io/eks-charts"
#   version    = "1.5.2"

#   set {
#     name  = "autoDiscoverAwsRegion"
#     value = "true"
#   }
#   set {
#     name  = "autoDiscoverAwsVpcID"
#     value = "true"
#   }
#   set {
#     name  = "clusterName"
#     value = aws_eks_cluster.this.name
#   }
# }

# resource "aws_iam_policy" "worker_alb_policy" {
#   name        = "worker-alb-policy"
#   description = "Worker policy for the AWS Load Balancer Ingress Controller"

#   policy = file("iam-policy.json")
# }

# resource "aws_iam_role_policy_attachment" "worker_alb_policy_attachment" {
#   policy_arn = aws_iam_policy.worker_alb_policy.arn
#   role       = aws_iam_role.node.name
# }

# # data "aws_iam_policy_document" "AWSLoadBalancerControllerIAMPolicy" {
# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]
# #     actions   = ["iam:CreateServiceLinkedRole"]

# #     condition {
# #       test     = "StringEquals"
# #       variable = "iam:AWSServiceName"
# #       values   = ["elasticloadbalancing.amazonaws.com"]
# #     }
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]

# #     actions = [
# #       "ec2:DescribeAccountAttributes",
# #       "ec2:DescribeAddresses",
# #       "ec2:DescribeAvailabilityZones",
# #       "ec2:DescribeInternetGateways",
# #       "ec2:DescribeVpcs",
# #       "ec2:DescribeVpcPeeringConnections",
# #       "ec2:DescribeSubnets",
# #       "ec2:DescribeSecurityGroups",
# #       "ec2:DescribeInstances",
# #       "ec2:DescribeNetworkInterfaces",
# #       "ec2:DescribeTags",
# #       "ec2:GetCoipPoolUsage",
# #       "ec2:DescribeCoipPools",
# #       "elasticloadbalancing:DescribeLoadBalancers",
# #       "elasticloadbalancing:DescribeLoadBalancerAttributes",
# #       "elasticloadbalancing:DescribeListeners",
# #       "elasticloadbalancing:DescribeListenerCertificates",
# #       "elasticloadbalancing:DescribeSSLPolicies",
# #       "elasticloadbalancing:DescribeRules",
# #       "elasticloadbalancing:DescribeTargetGroups",
# #       "elasticloadbalancing:DescribeTargetGroupAttributes",
# #       "elasticloadbalancing:DescribeTargetHealth",
# #       "elasticloadbalancing:DescribeTags",
# #     ]
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]

# #     actions = [
# #       "cognito-idp:DescribeUserPoolClient",
# #       "acm:ListCertificates",
# #       "acm:DescribeCertificate",
# #       "iam:ListServerCertificates",
# #       "iam:GetServerCertificate",
# #       "waf-regional:GetWebACL",
# #       "waf-regional:GetWebACLForResource",
# #       "waf-regional:AssociateWebACL",
# #       "waf-regional:DisassociateWebACL",
# #       "wafv2:GetWebACL",
# #       "wafv2:GetWebACLForResource",
# #       "wafv2:AssociateWebACL",
# #       "wafv2:DisassociateWebACL",
# #       "shield:GetSubscriptionState",
# #       "shield:DescribeProtection",
# #       "shield:CreateProtection",
# #       "shield:DeleteProtection",
# #     ]
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]

# #     actions = [
# #       "ec2:AuthorizeSecurityGroupIngress",
# #       "ec2:RevokeSecurityGroupIngress",
# #     ]
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]
# #     actions   = ["ec2:CreateSecurityGroup"]
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["arn:aws:ec2:*:*:security-group/*"]
# #     actions   = ["ec2:CreateTags"]

# #     condition {
# #       test     = "StringEquals"
# #       variable = "ec2:CreateAction"
# #       values   = ["CreateSecurityGroup"]
# #     }

# #     condition {
# #       test     = "Null"
# #       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
# #       values   = ["false"]
# #     }
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["arn:aws:ec2:*:*:security-group/*"]

# #     actions = [
# #       "ec2:CreateTags",
# #       "ec2:DeleteTags",
# #     ]

# #     condition {
# #       test     = "Null"
# #       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
# #       values   = ["true"]
# #     }

# #     condition {
# #       test     = "Null"
# #       variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
# #       values   = ["false"]
# #     }
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]

# #     actions = [
# #       "ec2:AuthorizeSecurityGroupIngress",
# #       "ec2:RevokeSecurityGroupIngress",
# #       "ec2:DeleteSecurityGroup",
# #     ]

# #     condition {
# #       test     = "Null"
# #       variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
# #       values   = ["false"]
# #     }
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]

# #     actions = [
# #       "elasticloadbalancing:CreateLoadBalancer",
# #       "elasticloadbalancing:CreateTargetGroup",
# #     ]

# #     condition {
# #       test     = "Null"
# #       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
# #       values   = ["false"]
# #     }
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]

# #     actions = [
# #       "elasticloadbalancing:CreateListener",
# #       "elasticloadbalancing:DeleteListener",
# #       "elasticloadbalancing:CreateRule",
# #       "elasticloadbalancing:DeleteRule",
# #     ]
# #   }

# #   statement {
# #     sid    = ""
# #     effect = "Allow"

# #     resources = [
# #       "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
# #       "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
# #       "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*",
# #     ]

# #     actions = [
# #       "elasticloadbalancing:AddTags",
# #       "elasticloadbalancing:RemoveTags",
# #     ]

# #     condition {
# #       test     = "Null"
# #       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
# #       values   = ["true"]
# #     }

# #     condition {
# #       test     = "Null"
# #       variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
# #       values   = ["false"]
# #     }
# #   }

# #   statement {
# #     sid    = ""
# #     effect = "Allow"

# #     resources = [
# #       "arn:aws:elasticloadbalancing:*:*:listener/net/*/*/*",
# #       "arn:aws:elasticloadbalancing:*:*:listener/app/*/*/*",
# #       "arn:aws:elasticloadbalancing:*:*:listener-rule/net/*/*/*",
# #       "arn:aws:elasticloadbalancing:*:*:listener-rule/app/*/*/*",
# #     ]

# #     actions = [
# #       "elasticloadbalancing:AddTags",
# #       "elasticloadbalancing:RemoveTags",
# #     ]
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]

# #     actions = [
# #       "elasticloadbalancing:ModifyLoadBalancerAttributes",
# #       "elasticloadbalancing:SetIpAddressType",
# #       "elasticloadbalancing:SetSecurityGroups",
# #       "elasticloadbalancing:SetSubnets",
# #       "elasticloadbalancing:DeleteLoadBalancer",
# #       "elasticloadbalancing:ModifyTargetGroup",
# #       "elasticloadbalancing:ModifyTargetGroupAttributes",
# #       "elasticloadbalancing:DeleteTargetGroup",
# #     ]

# #     condition {
# #       test     = "Null"
# #       variable = "aws:ResourceTag/elbv2.k8s.aws/cluster"
# #       values   = ["false"]
# #     }
# #   }

# #   statement {
# #     sid    = ""
# #     effect = "Allow"

# #     resources = [
# #       "arn:aws:elasticloadbalancing:*:*:targetgroup/*/*",
# #       "arn:aws:elasticloadbalancing:*:*:loadbalancer/net/*/*",
# #       "arn:aws:elasticloadbalancing:*:*:loadbalancer/app/*/*",
# #     ]

# #     actions = ["elasticloadbalancing:AddTags"]

# #     condition {
# #       test     = "StringEquals"
# #       variable = "elasticloadbalancing:CreateAction"

# #       values = [
# #         "CreateTargetGroup",
# #         "CreateLoadBalancer",
# #       ]
# #     }

# #     condition {
# #       test     = "Null"
# #       variable = "aws:RequestTag/elbv2.k8s.aws/cluster"
# #       values   = ["false"]
# #     }
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["arn:aws:elasticloadbalancing:*:*:targetgroup/*/*"]

# #     actions = [
# #       "elasticloadbalancing:RegisterTargets",
# #       "elasticloadbalancing:DeregisterTargets",
# #     ]
# #   }

# #   statement {
# #     sid       = ""
# #     effect    = "Allow"
# #     resources = ["*"]

# #     actions = [
# #       "elasticloadbalancing:SetWebAcl",
# #       "elasticloadbalancing:ModifyListener",
# #       "elasticloadbalancing:AddListenerCertificates",
# #       "elasticloadbalancing:RemoveListenerCertificates",
# #       "elasticloadbalancing:ModifyRule",
# #     ]
# #   }
# # }

# # resource "helm_release" "example" {
# #   name       = "my-local-chart"
# #   chart      = "../charts/example"
# # }

# # resource "aws_iam_policy" "worker_alb_policy" {
# #   name        = "worker-policy"
# #   description = "Worker policy for the ALB Ingress"

# #   policy = file("iam-policy.json")
# # }

# # resource "aws_iam_role_policy_attachment" "additional" {
# #   for_each = module.eks.eks_managed_node_groups

# #   policy_arn = aws_iam_policy.worker_alb_policy.arn
# #   role       = each.value.iam_role_name
# # }