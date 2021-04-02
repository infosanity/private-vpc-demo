resource "aws_instance" "public_noNAT_instance" {
  ami                  = "ami-0d712b3e6e1f798ef" # Amazon2 - eu-west-1
  instance_type        = "t3.micro"
  iam_instance_profile = aws_iam_instance_profile.ssm_managed_profile.name
  network_interface {
    network_interface_id = aws_network_interface.public_nic.id
    device_index         = 0
  }

  key_name = "HP-default"

  tags = merge(
    var.tags,
    {
      Name = "publicInstance"
    }
  )
}

resource "aws_network_interface" "public_nic" {
  subnet_id       = aws_subnet.public_noNAT.id
  security_groups = [aws_security_group.instance_sg.id]
  tags = merge(
    var.tags,
    {
      Name = "publicInstance_NIC"
    }
  )
}

resource "aws_security_group" "instance_sg" {
  name        = "ssm-managed-instance-sg"
  description = "For Instances managed via SSM"
  vpc_id      = aws_vpc.public.id
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = merge(
    var.tags,
    {
      Name = "sg_AllowEgress"
    }
  )
}
resource "aws_eip" "instance_eip" {
  vpc      = true
  instance = aws_instance.public_noNAT_instance.id
  tags = merge(
    var.tags,
    {
      Name = "publicInstanceEIP"
    }
  )
}