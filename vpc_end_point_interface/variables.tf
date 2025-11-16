variable "vpc_id" {
  type = string
  default = ""
}

variable "security_group_ids" {
  type = list(string)
  default = []
}

variable "service_name" {
  type = string
  default = ""
}
