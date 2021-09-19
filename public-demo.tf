module "public-vpc" {
  source = "./public-vpc"
  tags = {
    "Environment" = "Public"
  }
}
