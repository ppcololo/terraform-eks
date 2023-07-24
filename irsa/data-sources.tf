data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

data "tls_certificate" "this" {
  url = var.eks_cluster_identity_issuer
}