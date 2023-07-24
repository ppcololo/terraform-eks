module "vpc" {
  source             = "./network-module"
  vpc_cidr           = "10.0.0.0/16"
  vpc_cidr_public_a  = "10.0.1.0/24"
  vpc_cidr_public_b  = "10.0.2.0/24"
  vpc_cidr_public_c  = "10.0.3.0/24"
  vpc_cidr_private_a = "10.0.10.0/24"
  vpc_cidr_private_b = "10.0.11.0/24"
  vpc_cidr_private_c = "10.0.12.0/24"
}

module "eks" {
  source           = "./eks-cluster-module"
  vpc_id           = module.vpc.vpc_id
  vpc_cidr         = module.vpc.vpc_cidr
  eks_cluster_name = "test-eks-cluster"
  eks_version      = "1.26"
  eks_subnets      = module.vpc.cluster_subnets
  tags = {
    Task       = "test-task"
    Managed_by = "terraform"
  }

  depends_on = [module.vpc]
}

module "eks_cluster_node_group" {
  source = "./eks-cluster-node-group-module"

  eks_cluster_name     = module.eks.cluster_name
  eks_cluster_sg       = module.eks.cluster_sg
  eks_subnets          = module.eks.cluster_subnets
  nodegroup_name       = "eks-node-group"
  nodegroup_version    = "1.26"
  nodes_ami_type       = "AL2_x86_64"
  nodes_capacity_type  = "ON_DEMAND"
  nodes_desired        = "1"
  nodes_instance_types = ["t3.large"]
  nodes_max            = "3"
  nodes_min            = "1"
  tags                 = {}
  vpc_id               = module.vpc.vpc_id

  depends_on = [module.eks]
}

module "irsa" {
  source                      = "./irsa"
  eks_cluster_identity_issuer = module.eks.cluster_identity_issuer
  pod_role_name               = "s3-access-role"
  eks_cluster_name            = module.eks.cluster_name
  service_account_name        = "s3-access-sa"

  depends_on = [module.eks]
}
