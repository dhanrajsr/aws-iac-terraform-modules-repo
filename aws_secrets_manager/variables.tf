variable "name" {
  type        = string
  description = "The name of the secret in AWS Secrets Manager"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9/_+=.@-]+$", var.name))
    error_message = "Secret name must contain only alphanumeric characters and /_+=.@- symbols."
  }
  
  validation {
    condition     = length(var.name) >= 1 && length(var.name) <= 512
    error_message = "Secret name must be between 1 and 512 characters."
  }
}

variable "description" {
  type        = string
  description = "Description of the secret"
  default     = ""

}

variable "kms_key_id" {
  type        = string
  description = "The KMS key ID or ARN for encrypting the secret"
  default     = ""
  
  validation {
    condition = var.kms_key_id == "" || can(regex("^(arn:aws[a-z-]*:kms:[a-z0-9-]+:\\d{12}:key/[a-f0-9-]+|[a-f0-9-]+|alias/[a-zA-Z0-9/_-]+|arn:aws[a-z-]*:kms:[a-z0-9-]+:\\d{12}:alias/[a-zA-Z0-9/_-]+)$", var.kms_key_id))
    error_message = "KMS key must be a valid key ID, key ARN, alias name, or alias ARN."
  }
}

variable "secret_value" {
  type        = string
  description = "The secret value to store (JSON string for key-value pairs or plain text)"
  default     = ""
  sensitive   = true
  
  validation {
    condition     = length(var.secret_value) <= 65536
    error_message = "Secret value must not exceed 65536 characters."
  }
}

variable "recovery_window_in_days" {
  type        = number
  description = "Number of days that AWS Secrets Manager waits before deleting the secret"
  default     = 30
  
  validation {
    condition     = var.recovery_window_in_days >= 7 && var.recovery_window_in_days <= 30
    error_message = "Recovery window must be between 7 and 30 days."
  }
}

variable "enable_rotation" {
  type        = bool
  description = "Whether automatic rotation is enabled for this secret"
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the secret"
  default     = {}
  
  validation {
    condition     = length(var.tags) <= 50
    error_message = "Cannot have more than 50 tags."
  }
}
