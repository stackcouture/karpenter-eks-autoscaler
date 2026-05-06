variable "private_subnet_ids" {
  type        = list(string)
  description = "List of Private Subnet IDs"
}

variable "aws_eks_security_group_id" {
  type        = string
  description = "Security Group IDs"
}

variable "is_eks_cluster_enabled" {
  type        = bool
  description = "EKS Cluster Enabled"
}

variable "cluster_name" {
  type        = string
  description = "Cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version"
}

variable "endpoint_private_access" {
  type        = string
  description = "Cluster EndPoint Private Access"
}

variable "endpoint_public_access" {
  type        = string
  description = "Cluster EndPoint Public Access"
}

variable "env" {
  type        = string
  description = "Environment Name"
}

variable "eks_cluster_role_arn" {
  type        = string
  description = "EKS Cluster Role ARN"
}

variable "node_eks_role_arn" {
  type        = string
  description = "EKS NodeGroup Role ARN"
}

variable "desired_capacity" {
  type        = string
  description = "Desired Capacity"
}

variable "min_capacity" {
  type        = string
  description = "Minimum Capacity"
}

variable "max_capacity" {
  type        = string
  description = "Maximum capacity"
}

variable "instance_types" {
  type        = list(string)
  description = "Instance Types"
}