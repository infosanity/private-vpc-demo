resource "aws_vpc" "public" {
  cidr_block = "172.20.16.0/20"
  #   tags = {
  #     Name = "Public-Demo"
  #   }
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
  tags = {
    "Name" = "Public-NoNAT"
  }
}

resource "aws_subnet" "public_viaNAT" {
  vpc_id     = aws_vpc.public.id
  cidr_block = "172.20.17.0/24"
  tags = {
    "Name" = "Public-viaNAT"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.public.id
  tags = {
    "Name" = "SessionManagerDemo"
  }
}

resource "aws_route_table" "routes_public" {
  vpc_id = aws_vpc.public.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "routes_public_subnet" {
  subnet_id      = aws_subnet.public_noNAT.id
  route_table_id = aws_route_table.routes_public.id
}