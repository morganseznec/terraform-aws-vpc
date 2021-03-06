output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "The VPC ID"
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
  description = "The public subnet ID"
}

output "app_private_subnet_id" {
  value = aws_subnet.app_private_subnet.id
  description = "The App private subnet ID"
}

output "db_private_subnet_id" {
  value = aws_subnet.db_private_subnet.id
  description = "The DB private subnet ID"
}