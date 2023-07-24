# VPC
resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  tags = {
    Name = "test_vpc"
  }
}

# Public subnet A
resource "aws_subnet" "public_subnet_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_cidr_public_a
  availability_zone = "${data.aws_region.current.name}a"
  tags = {
    Name = "public-subnet-a"
  }
}

# Public subnet B
resource "aws_subnet" "public_subnet_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_cidr_public_b
  availability_zone = "${data.aws_region.current.name}b"
  tags = {
    Name = "public-subnet-b"
  }
}

# Public subnet C
resource "aws_subnet" "public_subnet_c" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_cidr_public_c
  availability_zone = "${data.aws_region.current.name}c"
  tags = {
    Name = "public-subnet-c"
  }
}

# Internet gateway
resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

# Private subnet A
resource "aws_subnet" "private_subnet_a" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_cidr_private_a
  availability_zone = "${data.aws_region.current.name}a"
  tags = {
    Name = "private-subnet-a"
  }
}

# Private subnet B
resource "aws_subnet" "private_subnet_b" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_cidr_private_b
  availability_zone = "${data.aws_region.current.name}b"
  tags = {
    Name = "private-subnet-b"
  }
}

# Private subnet C
resource "aws_subnet" "private_subnet_c" {
  vpc_id            = aws_vpc.this.id
  cidr_block        = var.vpc_cidr_private_c
  availability_zone = "${data.aws_region.current.name}c"
  tags = {
    Name = "private-subnet-c"
  }
}

# Elastic IP for NAT GW
resource "aws_eip" "nat_gw_eip" {
  domain     = "vpc"
  depends_on = [aws_internet_gateway.this]
}

# NAT gateway
resource "aws_nat_gateway" "nat_gateway" {
  allocation_id = aws_eip.nat_gw_eip.id
  subnet_id     = aws_subnet.public_subnet_a.id
  depends_on    = [aws_internet_gateway.this]
}

# Public route table
resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Public route table"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
}

# Association subnet public_subnet_a and public route table
resource "aws_route_table_association" "public_subnet_association_a" {
  subnet_id      = aws_subnet.public_subnet_a.id
  route_table_id = aws_route_table.public_route_table.id
}

# Association subnet public_subnet_b and public route table
resource "aws_route_table_association" "public_subnet_association_b" {
  subnet_id      = aws_subnet.public_subnet_b.id
  route_table_id = aws_route_table.public_route_table.id
}

# Association subnet public_subnet_c and public route table
resource "aws_route_table_association" "public_subnet_association_c" {
  subnet_id      = aws_subnet.public_subnet_c.id
  route_table_id = aws_route_table.public_route_table.id
}

# Private route table
resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.this.id
  tags = {
    Name = "Private route table"
  }
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gateway.id
  }
}

# Association private_subnet_a and private route table
resource "aws_route_table_association" "private_subnet_association_a" {
  subnet_id      = aws_subnet.private_subnet_a.id
  route_table_id = aws_route_table.private_route_table.id
}

# Association private_subnet_b and private route table
resource "aws_route_table_association" "private_subnet_association_b" {
  subnet_id      = aws_subnet.private_subnet_b.id
  route_table_id = aws_route_table.private_route_table.id
}

# Association private_subnet_c and private route table
resource "aws_route_table_association" "private_subnet_association_c" {
  subnet_id      = aws_subnet.private_subnet_c.id
  route_table_id = aws_route_table.private_route_table.id
}