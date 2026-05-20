variable "aws_region" {
  description = "AWS region for EKS deployment"
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_name" {
  description = "Name of the VPC for EKS"
  type        = string
  default     = "youtube-eks-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for EKS VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "Availability zones for EKS VPC"
  type        = list(string)
  default     = ["ap-southeast-2a", "ap-southeast-2b"]
}

variable "private_subnets" {
  description = "Private subnets for EKS worker nodes"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "public_subnets" {
  description = "Public subnets for load balancer and control plane access"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "youtube-eks-cluster"
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "allowed_cluster_access_cidr" {
  description = "CIDR allowed to access EKS public API endpoint"
  type        = string
}

variable "node_group_name" {
  description = "EKS managed node group name"
  type        = string
  default     = "youtube-node-group"
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS managed node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "node_min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "node_max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 2
}

variable "node_desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 1
}
