variable "vpc_id" {}
variable "vpc_cidr" {}
variable "eks_cluster_name" {}
variable "eks_subnets" {}
variable "tags" {
  type    = map(string)
  default = {}
}
variable "eks_version" {}
