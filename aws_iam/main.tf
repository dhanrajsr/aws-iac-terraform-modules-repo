resource "aws_iam_user" "user" {
  name = var.username
}

resource "aws_iam_access_key" "user" {
  user = aws_iam_user.user.name
}
