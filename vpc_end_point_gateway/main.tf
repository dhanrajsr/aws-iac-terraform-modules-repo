data "aws_vpc" "main" {
  id = var.vpc_id
}

resource "aws_vpc_endpoint" "endpoints" {
  vpc_id            = data.aws_vpc.main.id
  service_name      = var.service_name
  vpc_endpoint_type = "Gateway" # S3 uses a Gateway Endpoint
  route_table_ids   = var.route_table_ids
}
