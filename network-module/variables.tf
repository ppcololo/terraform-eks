# VPC CIDR
variable "vpc_cidr" {
  type        = string
  description = "CIDR for the whole VPC"
}

# Public subnet A CIDR
variable "vpc_cidr_public_a" {
  type        = string
  description = "CIDR for the Public subnet"
}

# Public subnet B CIDR
variable "vpc_cidr_public_b" {
  type        = string
  description = "CIDR for the Public subnet"
}

# Public subnet C CIDR
variable "vpc_cidr_public_c" {
  type        = string
  description = "CIDR for the Public subnet"
}

# Private subnet A CIDR
variable "vpc_cidr_private_a" {
  type        = string
  description = "CIDR for the Private subnet"
}

# Private subnet B CIDR
variable "vpc_cidr_private_b" {
  type        = string
  description = "CIDR for the Private subnet"
}

# Private subnet C CIDR
variable "vpc_cidr_private_c" {
  type        = string
  description = "CIDR for the Private subnet"
}

# Tags
variable "tags" {
  type        = map(any)
  description = "Tags"
  default = {
    Service    = "network"
    Managed_by = "terraform"
  }
}