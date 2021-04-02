module "public-vpc" {
  source = "./public-vpc"
  tags = merge(
    var.base_tags,
    {
      "Environment" = "Public"
    }
  )
}
