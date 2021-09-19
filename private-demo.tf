module "private-vpc" {
  count   = var.private_enable == true ? 1 : 0
  source  = "./private-vpc"
  keyname = aws_key_pair.key_pair.key_name
  tags = {
    "Environment" = "Private"
  }
}