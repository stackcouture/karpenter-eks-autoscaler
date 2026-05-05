locals {
  cluster_name = var.cluster_name
}

resource "aws_subnet" "public_subnet" {
  count                   = var.pub_subnet_count
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.pub_cidr_block, count.index)
  availability_zone       = element(var.pub_availability_zone, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name                                          = "${var.pub_sub_name}-${count.index + 1}"
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    "kubernetes.io/role/elb"                      = "1"
  }

  depends_on = [var.vpc_id]
}

resource "aws_subnet" "private_subnet" {
  count                   = var.pri_subnet_count
  vpc_id                  = var.vpc_id
  cidr_block              = element(var.pri_cidr_block, count.index)
  availability_zone       = element(var.pri_availability_zone, count.index)
  map_public_ip_on_launch = false

  tags = {
    Name                                          = "${var.pri_sub_name}-${count.index + 1}"
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb"             = "1"
  }

  depends_on = [var.vpc_id]
}