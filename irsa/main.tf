resource "kubernetes_service_account" "s3_access_service_account" {
  metadata {
    name = var.service_account_name
    annotations = {
      "eks.amazonaws.com/role-arn" : aws_iam_role.pod_s3_access.arn
    }
    namespace = "default"
  }
}

resource "aws_iam_openid_connect_provider" "openid" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = concat(data.tls_certificate.this.certificates[*].sha1_fingerprint)
  url             = var.eks_cluster_identity_issuer
}