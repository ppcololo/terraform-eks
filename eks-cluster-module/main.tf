resource "aws_cloudwatch_log_group" "cloudwatch" {
  name              = "/aws/eks/eks/cluster"
  retention_in_days = 30
}

resource "aws_eks_cluster" "this" {
  depends_on = [
    aws_cloudwatch_log_group.cloudwatch, aws_iam_role_policy_attachment.eks_cluster_policy_attachment
  ]
  name                      = var.eks_cluster_name
  role_arn                  = aws_iam_role.eks_cluster_role.arn
  version                   = var.eks_version
  enabled_cluster_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  vpc_config {
    subnet_ids              = var.eks_subnets
    security_group_ids      = [aws_security_group.cluster_sg.id]
    endpoint_private_access = "true"
    endpoint_public_access  = "true"
  }

  tags = merge(
    var.tags,
    {
      Name = "eks"
    }
  )
}