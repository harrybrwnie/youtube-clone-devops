module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  single_nat_gateway = true
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version

  vpc_id                   = module.vpc.vpc_id
  subnet_ids               = module.vpc.private_subnets
  control_plane_subnet_ids = module.vpc.public_subnets

  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = [var.allowed_cluster_access_cidr]

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {
    "${var.node_group_name}" = {
      min_size       = var.node_min_size
      max_size       = var.node_max_size
      desired_size   = var.node_desired_size
      instance_types = var.node_instance_types
      ami_type       = "AL2_x86_64"
    }
  }

  tags = {
    Project     = "youtube-clone-devops"
    Environment = "lab"
    ManagedBy   = "terraform"
  }
}
