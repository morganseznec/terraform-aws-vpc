output "vpc_id" {
  value = aws_vpc.vpc.id
  description = "The VPC ID"
}

output "public_subnet_id" {
  value = aws_subnet.public_subnet.id
  description = "The public subnet ID"
}

output "private_subnet_id" {
  value = aws_subnet.private_subnet.id
  description = "The private subnet ID"
}