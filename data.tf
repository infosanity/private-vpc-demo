# Linux base AMI
data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
}

output "amazon2-ami" {
  value = data.aws_ami.amazon_linux_2.id
}

# Windows Server base AMI
data "aws_ami" "windows" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["Windows_Server-2016-English-Full-Base*"]
  }
}

output "windows-ami" {
  value = data.aws_ami.windows.id
}