resource "aws_vpc" "public" {
  cidr_block           = "172.20.16.0/20"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = merge(
    var.tags,
    {
      "Name" = "Public-Demo"
    }
  )
}

resource "aws_subnet" "public_noNAT" {
  vpc_id     = aws_vpc.public.id
  cidr_block = "172.20.16.0/24"
  tags = merge(
    var.tags,
    {
      "Name" = "Public-NoNAT"
    }
  )
}

resource "aws_subnet" "public_viaNAT" {
  vpc_id     = aws_vpc.public.id
  cidr_block = "172.20.17.0/24"
  tags = merge(
    var.tags,
    {
      "Name" = "Public-viaNAT"
    }
  )
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.public.id
  tags = merge(
    var.tags,
    {
      "Name" = "SessionManagerDemo"
    }
  )
}

resource "aws_route_table" "routes_public" {
  vpc_id = aws_vpc.public.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = merge(
    var.tags,
    {
      "Name" = "PublicRoutes"
    }
  )
}

resource "aws_route_table_association" "routes_public_subnet" {
  subnet_id      = aws_subnet.public_noNAT.id
  route_table_id = aws_route_table.routes_public.id
}

resource "aws_eip" "NAT_GW_EIP" {
  depends_on = [
    aws_internet_gateway.igw
  ]

}

# NAT GW lives inside the public subnet
resource "aws_nat_gateway" "NAT_GW" {
  allocation_id = aws_eip.NAT_GW_EIP.id
  subnet_id     = aws_subnet.public_noNAT.id
  tags = merge(
    var.tags,
    {
      "Name" = "SessionManager_NatGateway"
    }
  )
}

resource "aws_route_table" "routes_nat" {
  vpc_id = aws_vpc.public.id
  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.NAT_GW.id
  }
}

resource "aws_route_table_association" "routes_via_NATGW" {
  subnet_id      = aws_subnet.public_viaNAT.id
  route_table_id = aws_route_table.routes_nat.id
}