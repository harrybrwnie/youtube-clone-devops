output "cluster_name" {
  description = "EKS cluster name"
  value       = module.eks.cluster_name
}

output "cluster_endpoint" {
  description = "EKS cluster endpoint"
  value       = module.eks.cluster_endpoint
}

output "vpc_id" {
  description = "VPC ID used by EKS"
  value       = module.vpc.vpc_id
}

output "private_subnets" {
  description = "Private subnet IDs used by EKS worker nodes"
  value       = module.vpc.private_subnets
}

output "public_subnets" {
  description = "Public subnet IDs used by load balancers"
  value       = module.vpc.public_subnets
}
