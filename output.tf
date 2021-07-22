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

output "nat_gateway_id" {
  value = aws_nat_gateway.nat_gw.id
  description = "The NAT Gateway ID"
}

output "internet_gateway_id" {
  value = aws_internet_gateway.gw.id
  description = "The Internet Gateway ID"
}

output "nat_route_table_id" {
  value = aws_route_table.nat_route_table.id
  description = "The NAT Route table ID"
}