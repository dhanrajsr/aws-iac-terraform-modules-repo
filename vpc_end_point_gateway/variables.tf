variable "vpc_id" {
  type = string
  default = ""
}

variable "route_table_ids" {
  description = "List of route table IDs to associate with the VPC endpoint"
  type        = list(string)
}

variable "service_name" {
  type = string
  default = ""
}

variable "vpc_endpoint_type" {
  type = string
  default = ""
}
