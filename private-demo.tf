module "private-vpc" {
  source = "./private-vpc"
  tags = {
    "Environment" = "Private"
  }
}