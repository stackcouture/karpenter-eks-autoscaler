module "vpc" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  env                  = var.env
  instance_tenancy     = var.instance_tenancy
  vpc_name             = var.vpc_name
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
}

module "igw" {
  source       = "./modules/igw"
  vpc_id       = module.vpc.vpc_id
  igw_name     = var.igw_name
  env          = var.env
  cluster_name = var.cluster_name
}

module "subnets" {
  source                = "./modules/subnets"
  vpc_id                = module.vpc.vpc_id
  env                   = var.env
  cluster_name          = var.cluster_name
  pub_sub_name          = var.pub_sub_name
  pub_subnet_count      = var.pub_subnet_count
  pub_cidr_block        = var.pub_cidr_block
  pub_availability_zone = var.pub_availability_zone

  pri_sub_name          = var.pri_sub_name
  pri_subnet_count      = var.pri_subnet_count
  pri_cidr_block        = var.pri_cidr_block
  pri_availability_zone = var.pri_availability_zone
}

module "route-table" {
  source             = "./modules/rt"
  vpc_id             = module.vpc.vpc_id
  env                = var.env
  public_rt_name     = var.public_rt_name
  private_rt_name    = var.private_rt_name
  igw_id             = module.igw.igw_id
  nat_gateway_id     = module.nat.nat_gateway_id
  public_subnet_ids  = module.subnets.public_subnets
  private_subnet_ids = module.subnets.private_subnets
}

module "nat" {
  source            = "./modules/nat"
  vpc_id            = module.vpc.vpc_id
  env               = var.env
  eip_name          = var.eip_name
  igw_id            = module.igw.igw_id
  nat_gw_name       = var.nat_gw_name
  public_subnet_ids = module.subnets.public_subnets
}

module "sg" {
  source         = "./modules/sg"
  vpc_id         = module.vpc.vpc_id
  env            = var.env
  sg_name        = var.sg_name
  sg_description = var.sg_description
  cluster_name   = var.cluster_name
}