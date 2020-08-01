variable "project" {
  type    = string
}

variable "availability_zone" {
  type = string
}

variable "public_subnet_cidr" {
  type    = string
  default = "10.44.1.0/24"
}

variable "public_subnet_map_public_ip" {
  type    = bool
  default = false
}

variable "app_private_subnet_cidr" {
  type    = string
  default = "10.44.2.0/24"
}

variable "app_private_subnet_map_public_ip" {
  type    = bool
  default = false
}

variable "db_private_subnet_cidr" {
  type    = string
  default = "10.44.3.0/24"
}

variable "db_private_subnet_map_public_ip" {
  type    = bool
  default = false
}

variable "vpc_cidr_block" {
  type    = string
  default = "10.44.0.0/16"
}

variable "env" {
  type    = string
  default = ""
}

variable "region_short" {
  type = map(string)
  default = {
    eu-central-1   = "ec1"
    eu-north-1     = "en1"
    eu-west-1      = "ew1"
    eu-west-2      = "ew2"
    eu-west-3      = "ew3"
    us-east-1      = "ue1"
    us-east-2      = "ue2"
    us-west-1      = "uw1"
    us-west-2      = "uw2"
    sa-east-1      = "se1"
    ap-northeast-1 = "an1"
    ap-northeast-2 = "an2"
    ap-south-1     = "as1"
    ap-southeast-1 = "ase1"
    ap-southeast-2 = "ase2"
    ca-central-1   = "cc1"
  }
}