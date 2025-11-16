resource "aws_subnet" "private-subnet" {
  vpc_id            = var.vpc_id
  cidr_block        = var.subnet_cidr
  availability_zone = var.subnet_az

  tags = {
    Name = var.subnet_name
  }
}

resource "aws_route_table_association" "private-us-west-2b" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = var.main_route_table_id
}
