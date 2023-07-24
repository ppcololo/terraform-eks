resource "aws_security_group" "cluster_sg" {
  name        = "tf-sg-eks-cluster"
  description = "sg for eks cluster"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "sg-eks-nodegroup-common"
    }
  )
}

