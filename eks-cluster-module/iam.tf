#### CLUSTER
data "aws_iam_policy_document" "eks_cluster_policy_doc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["eks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name               = "iamr-eks-cluster-role-${data.aws_region.current.name}"
  path               = "/service-role/"
  assume_role_policy = data.aws_iam_policy_document.eks_cluster_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy_attachment" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}
