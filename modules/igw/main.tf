locals {
  cluster_name = var.cluster_name
}

resource "aws_internet_gateway" "igw" {
  vpc_id = var.vpc_id

  tags = {
    Name                                          = var.igw_name
    Env                                           = var.env
    "kubernetes.io/cluster/${local.cluster_name}" = "owned"
  }
  depends_on = [var.vpc_id]
}