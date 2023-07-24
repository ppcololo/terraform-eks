resource "aws_security_group" "common_nodegroup_sg" {
  name        = "tf-sg-eks-nodegroup-common"
  description = "common sg for eks nodegroup"
  vpc_id      = var.vpc_id

  tags = merge(
    var.tags,
    {
      Name = "sg-eks-nodegroup-common"
    }
  )
}


resource "aws_security_group_rule" "nodegroup_self_ingress" {
  description       = "self"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.common_nodegroup_sg.id
}

resource "aws_security_group_rule" "nodegroup_self_egress" {
  description       = "self"
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  self              = true
  security_group_id = aws_security_group.common_nodegroup_sg.id
}

resource "aws_security_group_rule" "nodegroup_masters_ingress" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  type                     = "ingress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.eks_cluster_sg
  security_group_id        = aws_security_group.common_nodegroup_sg.id
}

resource "aws_security_group_rule" "nodegroup_masters_egress" {
  description              = "Allow worker Kubelets and pods to contact cluster control plane"
  type                     = "egress"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.eks_cluster_sg
  security_group_id        = aws_security_group.common_nodegroup_sg.id
}