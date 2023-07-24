output "vpc_id" {
  value = aws_vpc.this.id
}

output "vpc_cidr" {
  value = aws_vpc.this.cidr_block
}

output "vpc_cidr_public_a" {
  value = aws_subnet.public_subnet_a.cidr_block
}

output "vpc_cidr_public_b" {
  value = aws_subnet.public_subnet_b.cidr_block
}

output "vpc_cidr_public_c" {
  value = aws_subnet.public_subnet_c.cidr_block
}

output "vpc_cidr_private_a" {
  value = aws_subnet.private_subnet_a.cidr_block
}

output "vpc_cidr_private_b" {
  value = aws_subnet.private_subnet_b.cidr_block
}

output "vpc_cidr_private_c" {
  value = aws_subnet.private_subnet_c.cidr_block
}

output "nat_gw_eip" {
  value = aws_eip.nat_gw_eip.public_ip
}

output "cluster_subnets" {
  value = [
    aws_subnet.private_subnet_a.id, aws_subnet.private_subnet_b.id,
    aws_subnet.private_subnet_c.id
  ]
}