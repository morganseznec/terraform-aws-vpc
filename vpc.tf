
# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "vpc-${var.region_short[var.region]}-${var.env}-${var.project}"
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "gw-${var.region_short[var.region]}-${var.env}-${var.project}"
  }
}

# Create a default route table
resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = "rt-${var.region_short[var.region]}-${var.env}-${var.project}"
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = var.public_subnet_map_public_ip
  availability_zone       = join("", [var.region, var.availability_zone])

  tags = {
    Name = "public-subnet-${var.region_short[var.region]}-${var.env}-${var.project}"
  }
}

# Create a private subnet
resource "aws_subnet" "app_private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.app_private_subnet_cidr
  map_public_ip_on_launch = var.app_private_subnet_map_public_ip
  availability_zone       = join("", [var.region, var.availability_zone])

  tags = {
    Name = "private-subnet-${var.region_short[var.region]}-${var.env}-${var.project}-app"
  }
}

# Create a private subnet
resource "aws_subnet" "db_private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.db_private_subnet_cidr
  map_public_ip_on_launch = var.db_private_subnet_map_public_ip
  availability_zone       = join("", [var.region, var.availability_zone])

  tags = {
    Name = "private-subnet-${var.region_short[var.region]}-${var.env}-${var.project}-db"
  }
}

# Create an Elastic IP
resource "aws_eip" "eip_nat" {
  vpc = true
  tags = {
    Name = "eip-${var.region_short[var.region]}-${var.env}-${var.project}"
  }
}

# Create a NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "nat-gw-${var.region_short[var.region]}-${var.env}-${var.project}"
  }
}

#
# Allow Internet access to instances in the private subnet
#

# Create a route table
resource "aws_route_table" "nat_route_table" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.nat_gw.id
  }
}

# Create a route table association between private subnet and nat gateway
resource "aws_route_table_association" "app_subnet_to_nat_gw" {
  route_table_id = aws_route_table.nat_route_table.id
  subnet_id      = aws_subnet.app_private_subnet.id
}

# Create a route table association between private subnet and nat gateway
resource "aws_route_table_association" "db_subnet_to_nat_gw" {
  route_table_id = aws_route_table.nat_route_table.id
  subnet_id      = aws_subnet.db_private_subnet.id
}