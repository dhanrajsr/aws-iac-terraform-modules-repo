variable "name" {
  description = "Name prefix for created resources"
  type        = string
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the instances."
  default     = ""
}

variable "tags" {
  description = "Map of tags to attach to all resources, most common keys: Name, component, environment"
  type        = map(any)
  default     = {}
}

variable "instance_type" {
  type        = string
  description = "instance type example r5.large"
  default     = ""
}

variable "tenancy" {
  type        = string
  description = "tenancy types like default, dedicated or host"
  default     = ""
}

variable "volume_size" {
  type        = string
  description = "Volume size in GB"
  default     = "0"
}

variable "volume_type" {
  type        = string
  description = "Volume type like gp2, gp3"
  default     = ""
}

variable "delete_on_termination" {
  type        = bool
  description = "Deletes volume on ec2 termination"
  default     = true
}

variable "ebs_encryption" {
  type        = bool
  description = "Enable encryption on EBS volume"
  default     = true
}

variable "kms_key_arn" {
  type        = string
  description = "KMS Key ARN"
  default     = ""
}

variable "instance_profile_arn" {
  type        = string
  description = "IAM instance profile ARN"
  default     = ""
}

variable "user_data" {
  type        = string
  description = "user data to be added to launch template"
  default     = ""
}

variable "device_name" {
  type        = string
  description = "device attached in ami"
  default     = ""
}

variable "security_group" {
  type        = list(string)
  description = "security group names"
  default     = [""]
}
