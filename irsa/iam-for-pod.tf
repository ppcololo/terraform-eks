data "aws_iam_policy_document" "s3_access" {
  statement {
    actions = [
      "s3:*"
    ]

    resources = [
      "*",
    ]
  }
}

resource "aws_iam_policy" "pod_policy" {
  name        = "iamp-${data.aws_region.current.name}-pod-s3-access"
  description = "Policy for EKS pod"
  path        = "/"
  policy      = data.aws_iam_policy_document.s3_access.json
}

resource "aws_iam_role" "pod_s3_access" {
  name = var.pod_role_name
  path = "/service-role/"
  assume_role_policy = jsonencode(
    {
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Principal" : {
            "Federated" : "arn:aws:iam::${data.aws_caller_identity.current.account_id}:oidc-provider/${trimprefix(var.eks_cluster_identity_issuer, "https://")}"
          },
          "Action" : "sts:AssumeRoleWithWebIdentity",
          "Condition" : {
            "StringEquals" : {
              "${trimprefix(var.eks_cluster_identity_issuer, "https://")}:sub" : "system:serviceaccount:default:${var.service_account_name}"
            }
          }
        }
      ]
  })
}

resource "aws_iam_role_policy_attachment" "this" {
  role       = aws_iam_role.pod_s3_access.name
  policy_arn = aws_iam_policy.pod_policy.arn
}