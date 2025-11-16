data "aws_vpc" "main" {
  id = var.vpc_id
}

data "aws_subnets" "private" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }
}

data "aws_subnet" "private" {
  for_each = toset(data.aws_subnets.private.ids)
  id       = each.value
}

resource "aws_vpc_endpoint" "endpoints" {
  vpc_id            = data.aws_vpc.main.id
  service_name      = var.service_name
  vpc_endpoint_type = var.vpc_endpoint_type
  subnet_ids        = data.aws_subnets.private.ids
  security_group_ids = var.security_group_ids
  private_dns_enabled = true
}
