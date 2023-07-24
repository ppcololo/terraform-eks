output "cluster_name" {
  value = aws_eks_cluster.this.name
}

output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}

output "cluster_certificate_authority_data" {
  value = aws_eks_cluster.this.certificate_authority.0.data
}

output "cluster_subnets" {
  value = aws_eks_cluster.this.vpc_config[0].subnet_ids
}

output "cluster_identity_issuer" {
  value = aws_eks_cluster.this.identity.0.oidc.0.issuer
}

output "cluster_sg" {
  value = aws_security_group.cluster_sg.id
}