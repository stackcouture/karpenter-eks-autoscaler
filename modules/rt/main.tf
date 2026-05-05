resource "aws_route_table" "public_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.igw_id
  }

  tags = {
    Name = var.public_rt_name
    env  = var.env
  }
}

resource "aws_route_table_association" "name" {
  for_each       = { for idx, subnet_id in var.public_subnet_ids : idx => subnet_id } # Convert list to map
  subnet_id      = each.value
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table" "private_rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.nat_gateway_id
  }

  tags = {
    Name = var.private_rt_name
    env  = var.env
  }
}

resource "aws_route_table_association" "private_rta" {
  for_each       = { for idx, subnet_id in var.private_subnet_ids : idx => subnet_id }
  subnet_id      = each.value
  route_table_id = aws_route_table.private_rt.id
}