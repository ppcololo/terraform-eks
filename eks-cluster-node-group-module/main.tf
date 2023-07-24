resource "aws_eks_node_group" "lt_nodegroup" {
  depends_on   = [aws_launch_template.nodegroup_lt]
  cluster_name = var.eks_cluster_name

  node_group_name = "eks-lt-nodegroup-${var.nodegroup_name}"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn
  subnet_ids      = var.eks_subnets
  version         = var.nodegroup_version

  ami_type       = var.nodes_ami_type
  capacity_type  = var.nodes_capacity_type
  instance_types = var.nodes_instance_types

  launch_template {
    id      = aws_launch_template.nodegroup_lt.id
    version = aws_launch_template.nodegroup_lt.latest_version
  }
  scaling_config {
    desired_size = var.nodes_desired
    max_size     = var.nodes_max
    min_size     = var.nodes_min
  }
  tags = merge(
    var.tags,
    {
      Name = "eks"
    }
  )

  lifecycle {
    ignore_changes        = [scaling_config[0].desired_size]
    create_before_destroy = true
  }
}

resource "aws_launch_template" "nodegroup_lt" {
  name_prefix = "lt-eks-nodegroup-${var.nodegroup_name}-"

  network_interfaces {
    associate_public_ip_address = false
    security_groups = [
    ]
  }
  block_device_mappings {
    device_name = "/dev/xvda"
    ebs {
      volume_type = "gp3"
      volume_size = 20
    }
  }
  tag_specifications {
    resource_type = "volume"
    tags = merge(
      var.tags,
      {
        Name = "ebs-eks-lt-nodegroup-${var.nodegroup_name}"
      }
    )
  }
  tag_specifications {
    resource_type = "instance"
    tags = merge(
      var.tags,
      {
        Name = "ec2-eks-lt-nodegroup-${var.nodegroup_name}"
      }
    )
  }
}
