output "security_group_arn" {
  value = aws_security_group.security-group.arn
}
output "security_group_rules" {
  value = aws_security_group_rule.rules[*]
}

output "security_group_id" {
  value = aws_security_group.security-group.id
}

output "security_group_name" {
  value = aws_security_group.security-group.name
}
