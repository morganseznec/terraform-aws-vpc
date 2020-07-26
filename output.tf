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

output "bastion_public_subnet_id" {
  value = aws_subnet.bastion_public_subnet.0.id
  description = "The Bastion public subnet ID"

  depends_on = [ aws_subnet.bastion_public_subnet.0 ]
}