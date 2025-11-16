output "vpc_id" {
  value = aws_vpc.main.id
  description = "VPC name"
}

output "vpc_main_route_table_id" {
  value = aws_vpc.main.main_route_table_id
  description = "VPC main route table id"
}

