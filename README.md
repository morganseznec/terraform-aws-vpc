# terraform-aws-vpc

Terraform Module for provisioning an AWS VPC.

Features:

* Automatically creates public and private subnets
* Internet gateway and default route table included

## Usage

### Example

```hcl
module "example_vpc" {
  source                         = "github.com/morganseznec/terraform-aws-vpc"
  project                        = "myproject"
  vpc_cidr_block                 = "10.44.0.0/16"
  region                         = "us-east-1"
  availability_zone              = "a"
  public_subnet_cidr_block       = "10.44.1.0/24"
  public_subnet_map_public_ip    = false
  private_subnet_cidr_block      = "10.44.2.0/24"
  private_subnet_map_public_ip   = false
  env                            = "t"
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
| project | Project name | `string` | `""` | yes |
| vpc_cidr_block | The CIDR used for the VPC | `string` | `10.44.0.0/16` | no |
| region | AWS region | `string` | `""` | yes |
| availability_zone | Availability zone (a, b, c, d) | `string` | `""` | yes |
| public_subnet_cidr_block | The subnet cidr block | `string` | `10.44.1.0/24` | no |
| public_subnet_map_public_ip | Map public IP on launch | `bool` | `false` | no |
| private_subnet_cidr_block | The subnet cidr block | `string` | `10.44.2.0/24` | no |
| private_subnet_map_public_ip | Map public IP on launch | `bool` | `false` | no |
| env | Environment (t (test), s (staging), p (prod)) | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| vpc_id | VPC ID |
| public_subnet_id | Public subnet ID |
| private_subnet_id | Private subnet ID |

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)
