resource "aws_security_group_rule" "eks_cluster_ingress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.cluster_sg.id
  to_port           = 0
  type              = "ingress"
  cidr_blocks       = [var.vpc_cidr]
}

resource "aws_security_group_rule" "eks_cluster_egress" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = aws_security_group.cluster_sg.id
  to_port           = 0
  type              = "egress"
  cidr_blocks       = [var.vpc_cidr]
}

resource "aws_security_group_rule" "api_access_for_management" {
  description       = "Allow users to reach cluster API with kubectl"
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = aws_security_group.cluster_sg.id
}