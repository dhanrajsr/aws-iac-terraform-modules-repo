variable "security_group_name" {
  default = ""
}
variable "vpc_name" {
  default = ""
}

variable "rules" {
  description = "Maps of Ingress Rules"
  type        = any
  default     = {}
}
