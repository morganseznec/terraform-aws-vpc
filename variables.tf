variable "subnet_name" {
  type = string
}

variable "subnet_cidr_block" {
  type    = string
  default = "10.44.1.0/24"
}

variable "vpc_name" {
  type = string
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.44.0.0/16"
}

variable "env" {
  type    = string
  default = ""
}

variable "gw_name" {
  type = string
  default = "gw-default"
}

variable "default_route_table_name" {
  type = string
  default = "default-route-table"
}