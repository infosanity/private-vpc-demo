resource "aws_vpc" "private" {
  cidr_block = "172.20.0.0/20"
  tags = {
    Name = "Private-Demo"
  }
  enable_dns_hostnames = true
  enable_dns_support   = true

}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.private.id
  cidr_block = "172.20.0.0/24"
}

resource "aws_security_group" "vpc_ep_sg" {
  name        = "allow_vpc_endpoint"
  description = "Allow access to VPC Endpoints"
  vpc_id      = aws_vpc.private.id
  ingress {
    description = "Allow HTTPs to VPC Endpoint"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.private.cidr_block]
  }
  egress {
    description = "Allow VPC Endpoint"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [aws_vpc.private.cidr_block]
  }
}

resource "aws_vpc_endpoint" "ssm" {
  vpc_id              = aws_vpc.private.id
  service_name        = "com.amazonaws.eu-west-1.ssm"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpc_ep_sg.id]
  subnet_ids          = [aws_subnet.private.id]
  private_dns_enabled = true
  tags = {
    "Name" = "SSM"
  }
}

resource "aws_vpc_endpoint" "ssmmessages" {
  vpc_id              = aws_vpc.private.id
  service_name        = "com.amazonaws.eu-west-1.ssmmessages"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpc_ep_sg.id]
  subnet_ids          = [aws_subnet.private.id]
  private_dns_enabled = true
  tags = {
    "Name" = "SSMMessages"
  }
}

resource "aws_vpc_endpoint" "ec2messages" {
  vpc_id              = aws_vpc.private.id
  service_name        = "com.amazonaws.eu-west-1.ec2messages"
  vpc_endpoint_type   = "Interface"
  security_group_ids  = [aws_security_group.vpc_ep_sg.id]
  subnet_ids          = [aws_subnet.private.id]
  private_dns_enabled = true
  tags = {
    "Name" = "ec2Messages"
  }
}