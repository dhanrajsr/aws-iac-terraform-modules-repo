data "aws_vpc" "vpc" {
  filter {
    name = "tag:Name"
    values = [var.vpc_name]
  }
}

resource "aws_security_group" "security-group" {
  name        = "SG-${var.security_group_name}"
  description = var.security_group_name
  vpc_id      = data.aws_vpc.vpc.id

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  lifecycle {
    create_before_destroy = true
  }
  tags = {
    Name = var.security_group_name
  }
}

resource "aws_security_group_rule" "rules" {
  for_each          = var.rules
  description       = each.value["description"]
  cidr_blocks       = each.value["cidr_blocks"]
  from_port         = each.value["from_port"]
  to_port           = each.value["to_port"]
  protocol          = each.value["protocol"]
  security_group_id = aws_security_group.security-group.id
  type              = "ingress"
}
