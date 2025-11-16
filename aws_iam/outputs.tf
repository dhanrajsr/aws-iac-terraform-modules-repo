output "username" {
  value = aws_iam_access_key.user.user
}

output "access_key_id" {
  value = aws_iam_access_key.user.id
}

output "secret_access_key" {
  value = aws_iam_access_key.user.secret
}

output "encrypted_secret_access_key" {
  value = aws_iam_access_key.user.encrypted_secret
}
