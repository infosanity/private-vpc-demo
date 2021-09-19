module "public-vpc" {
  count = var.public_enable == true ? 1 : 0
  source = "./public-vpc"
  tags = {
    "Environment" = "Public"
  }
}
