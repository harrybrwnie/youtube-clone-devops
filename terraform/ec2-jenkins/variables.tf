variable "aws_region" {
  description = "AWS region for deployment"
  type        = string
  default     = "ap-southeast-2"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed to access SSH"
  type        = string
}

variable "allowed_web_cidr" {
  description = "CIDR allowed to access Jenkins and SonarQube"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for Jenkins EC2 instance"
  type        = string
  default     = "ami-09c866a0ebb08de3d"
}

variable "instance_type" {
  description = "EC2 instance type for Jenkins server"
  type        = string
  default     = "t3.medium"
}

variable "key_name" {
  description = "Existing AWS EC2 key pair name"
  type        = string
}

variable "root_volume_size" {
  description = "Root volume size in GB"
  type        = number
  default     = 30
}
