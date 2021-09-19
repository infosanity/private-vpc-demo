module "private-vpc" {
  count  = var.private_enable == true ? 1 : 0
  source = "./private-vpc"
  tags = {
    "Environment" = "Private"
  }
}