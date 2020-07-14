# terraform-aws-vpc

Terraform Module for provisioning an AWS VPC.

Features:

* Automatically create a subnet
* Internet gateway and default route table included

## Usage

```hcl
module "example_vpc" {
  source                   = "github.com/morganseznec/terraform-aws-vpc"
  vpc_name                 = "vpc-example"
  vpc_cidr_block           = "10.44.0.0/16"
  subnet_name              = "subnet-example"
  subnet_cidr_block        = "10.44.1.0/24"
  gw_name                  = "gw-example"
  default_route_table_name = "default-route-table"
  env                      = "test"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | ~> 0.12.28 |
| aws | ~> 2.69 |

## Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| vpc_name | VPC name | `string` | `""` | yes |
| vpc_cidr_block | The CIDR used for the VPC | `string` | `10.44.0.0/16` | no |
| subnet_name | The subnet name | `string` | `""` | yes |
| subnet_cidr_block | The subnet cidr block | `string` | `10.44.1.0/24` | no |
| gw_name | The Internet gateway name | `string` | `"gw-default"` | no |
| default_route_table_name | The default route table name | `string` | `"default-route-table"` | no |
| env | Environment name. It should be: test, bench, staging or prod. | `string` | `""` | no |

## Outputs

No output.

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0) 
