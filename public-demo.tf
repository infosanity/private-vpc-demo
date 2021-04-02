module "public-vpc" {
  source = "./public-vpc"
  tags = var.base_tags
}
