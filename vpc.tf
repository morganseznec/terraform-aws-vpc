# Get current Region
data "aws_region" "region" {} 

# Create a VPC
resource "aws_vpc" "vpc" {
  cidr_block = var.vpc_cidr_block
  tags = {
    Name = "vpc-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}"
    Project = var.project
    Country = var.country
  }
}

# Create an internet gateway
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "gw-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}"
    Project = var.project
    Country = var.country
  }
}

resource "aws_vpn_gateway" "private_gateway" {
  vpc_id          = aws_vpc.vpc.id
  amazon_side_asn = var.vpn_gateway_amazon_side_asn
  tags = {
    Name = "vgw-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}"
    Project = var.project
    Country = var.country
  }
}

resource "aws_vpn_gateway_route_propagation" "route_propagation" {
  vpn_gateway_id = aws_vpn_gateway.private_gateway.id
  route_table_id = aws_route_table.nat_route_table.id
}

# Create a default route table
resource "aws_default_route_table" "route_table" {
  default_route_table_id = aws_vpc.vpc.default_route_table_id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }

  propagating_vgws = [aws_vpn_gateway.private_gateway.id]

  dynamic "route" {
      for_each = var.peering_routes
      content {
        cidr_block     = route.value.cidr_block
        vpc_peering_connection_id = route.value.vpc_peering_connection_id
      }
  }

  tags = {
    Name = "rt-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}"
    Project = var.project
    Country = var.country
  }
}

# Create a public subnet
resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr
  map_public_ip_on_launch = var.public_subnet_map_public_ip
  availability_zone       = join("", [data.aws_region.region.name, var.availability_zone])

  tags = {
    Name = "public-subnet-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}"
    Project = var.project
    Country = var.country
  }
}

# Create a private subnet
resource "aws_subnet" "app_private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.app_private_subnet_cidr
  map_public_ip_on_launch = var.app_private_subnet_map_public_ip
  availability_zone       = join("", [data.aws_region.region.name, var.availability_zone])

  tags = {
    Name = "private-subnet-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}-app"
    Project = var.project
    Country = var.country
  }
}

# Create a private subnet
resource "aws_subnet" "db_private_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.db_private_subnet_cidr
  map_public_ip_on_launch = var.db_private_subnet_map_public_ip
  availability_zone       = join("", [data.aws_region.region.name, var.availability_zone])

  tags = {
    Name = "private-subnet-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}-db"
    Project = var.project
    Country = var.country
  }
}

# Create an Elastic IP
resource "aws_eip" "eip_nat" {
  vpc = true
  tags = {
    Name = "eip-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}"
    Project = var.project
    Country = var.country
  }
}

# Create a NAT gateway
resource "aws_nat_gateway" "nat_gw" {
  allocation_id = aws_eip.eip_nat.id
  subnet_id     = aws_subnet.public_subnet.id

  tags = {
    Name = "nat-gw-${var.region_short[data.aws_region.region.name]}-${var.env}-${var.project}"
    Project = var.project
    Country = var.country
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

  dynamic "route" {
      for_each = var.routes
      content {
        cidr_block     = route.value.cidr_block
        instance_id = try(route.value.instance_id, null)
        network_interface_id = try(route.value.network_interface_id, null)
      }
  }

    dynamic "route" {
      for_each = var.peering_routes
      content {
        cidr_block     = route.value.cidr_block
        vpc_peering_connection_id = route.value.vpc_peering_connection_id
      }
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