variable "vpc_id" {}
variable "eks_cluster_name" {}
variable "eks_cluster_sg" {}
variable "eks_subnets" {}
variable "nodegroup_name" {}
variable "nodes_instance_types" {}
variable "nodegroup_version" {}
variable "nodes_ami_type" {}
variable "nodes_capacity_type" {}
variable "nodes_desired" {}
variable "nodes_max" {}
variable "nodes_min" {}
variable "tags" {
  type    = map(string)
  default = {}
}