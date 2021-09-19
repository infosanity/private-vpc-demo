module "public-vpc" {
  count       = var.public_enable == true ? 1 : 0
  source      = "./public-vpc"
  keyname     = aws_key_pair.key_pair.key_name
  amazon2_ami = data.aws_ami.amazon_linux_2.id
  tags = {
    "Environment" = "Public"
  }
}

output "public_noNAT_instance" {
  value = module.public-vpc[0].public_noNAT_instance
}

output "public_NAT_instance" {
  value = module.public-vpc[0].public_NAT_instance
}