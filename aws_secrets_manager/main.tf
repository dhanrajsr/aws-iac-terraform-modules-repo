resource "aws_secretsmanager_secret" "this" {
  name                           = var.name
  description                    = var.description
  kms_key_id                     = var.kms_key_id != "" ? var.kms_key_id : null
  recovery_window_in_days        = var.recovery_window_in_days
  force_overwrite_replica_secret = false

  tags = var.tags
}

resource "aws_secretsmanager_secret_version" "this" {
  count = var.secret_value != "" ? 1 : 0

  secret_id     = aws_secretsmanager_secret.this.id
  secret_string = var.secret_value

  lifecycle {
    ignore_changes = [secret_string]
  }
}
