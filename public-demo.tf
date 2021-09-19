module "public-vpc" {
  count   = var.public_enable == true ? 1 : 0
  source  = "./public-vpc"
  keyname = aws_key_pair.key_pair.key_name
  tags = {
    "Environment" = "Public"
  }

}
