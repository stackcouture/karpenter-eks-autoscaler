# VPC Variables 
variable "vpc_cidr" {
  type        = string
  description = "VPC CIDR Block"
}

variable "instance_tenancy" {
  type        = string
  description = "VPC Instance Tenancy"
}

variable "vpc_name" {
  type        = string
  description = "VPC Name"
}

variable "env" {
  type        = string
  description = "Environment Name"
}

variable "enable_dns_support" {
  type        = bool
  description = "Enable DNS Support"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "Enable DNS Hostnam"
}

# IGW 
variable "igw_name" {
  type        = string
  description = "Internet Gateway Name"
}

variable "cluster_name" {
  type        = string
  description = "Cluster Name"
}

# Subnets 
variable "pub_subnet_count" {}
variable "pub_cidr_block" {
  type = list(string)
}
variable "pub_availability_zone" {
  type = list(string)
}

variable "pub_sub_name" {}
variable "pri_subnet_count" {}
variable "pri_cidr_block" {
  type = list(string)
}
variable "pri_availability_zone" {
  type = list(string)
}
variable "pri_sub_name" {}