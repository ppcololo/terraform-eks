#### NODEGROUP
data "aws_iam_policy_document" "eks_nodegroup_policy_doc" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "eks_nodegroup_role" {
  name               = "iamr-eks-nodegroup-${var.nodegroup_name}"
  assume_role_policy = data.aws_iam_policy_document.eks_nodegroup_policy_doc.json
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy_attachment_worker" {
  role       = aws_iam_role.eks_nodegroup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy_attachment_ecr" {
  role       = aws_iam_role.eks_nodegroup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_iam_role_policy_attachment" "eks_nodegroup_policy_attachment_cni" {
  role       = aws_iam_role.eks_nodegroup_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}
