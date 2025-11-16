variable "deletion_window_in_days" {
  type        = number
  default     = 10
  description = "Duration in days after which the key is deleted after destruction of the resource"

  validation {
    condition     = var.deletion_window_in_days >= 7 && var.deletion_window_in_days <= 30
    error_message = "The deletion_window_in_days must be between 7 and 30 days."
  }
}

variable "enable_key_rotation" {
  type        = bool
  default     = true
  description = "Specifies whether key rotation is enabled"
}

variable "description" {
  type        = string
  default     = "Parameter Store KMS master key"
  description = "The description of the key as viewed in AWS console"

  validation {
    condition     = length(var.description) <= 8192
    error_message = "The description must not exceed 8192 characters."
  }
}

variable "alias" {
  type        = string
  default     = ""
  description = "The display name of the alias. The name must start with the word `alias` followed by a forward slash. If not specified, the alias name will be auto-generated."

  validation {
    condition     = var.alias == "" || can(regex("^[a-zA-Z0-9/_-]+$", var.alias))
    error_message = "The alias name can only contain alphanumeric characters, forward slashes (/), underscores (_), and dashes (-)."
  }

  validation {
    condition     = var.alias == "" || !startswith(var.alias, "aws/")
    error_message = "The alias cannot start with 'aws/' as it is reserved for AWS managed keys."
  }

  validation {
    condition     = var.alias == "" || (length(var.alias) >= 1 && length(var.alias) <= 256)
    error_message = "The alias name must be between 1 and 256 characters long."
  }
}

variable "policy" {
  type        = string
  default     = ""
  description = "A valid KMS policy JSON document. Note that if the policy document is not specific enough (but still valid), Terraform may view the policy as constantly changing in a terraform plan. In this case, please make sure you use the verbose/specific version of the policy."

  validation {
    condition     = var.policy == "" || can(jsondecode(var.policy))
    error_message = "The policy must be a valid JSON document."
  }

  validation {
    condition     = var.policy == "" || length(var.policy) <= 32768
    error_message = "The policy document must not exceed 32,768 characters."
  }
}

variable "key_usage" {
  type        = string
  default     = "ENCRYPT_DECRYPT"
  description = "Specifies the intended use of the key. Valid values: `ENCRYPT_DECRYPT` or `SIGN_VERIFY`."

  validation {
    condition     = contains(["ENCRYPT_DECRYPT", "SIGN_VERIFY"], var.key_usage)
    error_message = "The key_usage must be either 'ENCRYPT_DECRYPT' or 'SIGN_VERIFY'."
  }
}

variable "customer_master_key_spec" {
  type        = string
  default     = "SYMMETRIC_DEFAULT"
  description = "Specifies whether the key contains a symmetric key or an asymmetric key pair and the encryption algorithms or signing algorithms that the key supports. Valid values: `SYMMETRIC_DEFAULT`, `RSA_2048`, `RSA_3072`, `RSA_4096`, `ECC_NIST_P256`, `ECC_NIST_P384`, `ECC_NIST_P521`, or `ECC_SECG_P256K1`."

  validation {
    condition = contains([
      "SYMMETRIC_DEFAULT",
      "RSA_2048",
      "RSA_3072",
      "RSA_4096",
      "ECC_NIST_P256",
      "ECC_NIST_P384",
      "ECC_NIST_P521",
      "ECC_SECG_P256K1",
      "HMAC_224",
      "HMAC_256",
      "HMAC_384",
      "HMAC_512",
    ], var.customer_master_key_spec)
    error_message = "The customer_master_key_spec must be one of: SYMMETRIC_DEFAULT, RSA_2048, RSA_3072, RSA_4096, ECC_NIST_P256, ECC_NIST_P384, ECC_NIST_P521, ECC_SECG_P256K1, HMAC_224, HMAC_256, HMAC_384, HMAC_512, or SM2."
  }
}

variable "multi_region" {
  type        = bool
  default     = false
  description = "Indicates whether the KMS key is a multi-Region (true) or regional (false) key."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Map of tags to apply to the KMS key/alias."

  validation {
    condition = alltrue([
      for k, v in var.tags :
      length(k) <= 128 &&              # AWS tag key limit
      !startswith(lower(k), "aws:") && # reserved prefix
      length(v) <= 256                 # AWS tag value limit
    ])
    error_message = "Each tag key must be ≤128 characters, must not start with \"aws:\", and each tag value must be ≤256 characters."
  }
}
