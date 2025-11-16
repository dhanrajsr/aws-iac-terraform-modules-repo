variable "vpc_id" {
  type = string
  description = "VPC id to associate subnet"
  default = ""
}

variable "subnet_name" {
  type = string
  description = "Name of the subnet"
  default = ""
}

variable "subnet_cidr" {
  type = string
  description = "CIDR block for the subnet"
  default = ""
}

variable "subnet_az" {
  type = string
  description = "subnet AZ name"
  default = ""
}

variable "main_route_table_id" {
  type = string
  description = "id of main route table"
  default = ""
}
