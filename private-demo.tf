module "private-vpc" {
  count       = var.private_enable == true ? 1 : 0
  source      = "./private-vpc"
  keyname     = aws_key_pair.key_pair.key_name
  amazon2_ami = data.aws_ami.amazon_linux_2.id
  tags = {
    "Environment" = "Private"
  }
}

output "private_instance" {
  value = module.private-vpc[0].private_instance
}