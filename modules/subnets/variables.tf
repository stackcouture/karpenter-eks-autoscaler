variable "vpc_id" {
  type        = string
  description = "VPC ID"
}

variable "cluster_name" {
  type        = string
  description = "Cluster Name"
}

variable "env" {
  type        = string
  description = "Environment Name"
}

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