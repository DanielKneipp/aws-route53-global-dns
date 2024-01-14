module "services_sa" {
  source   = "./service"
  for_each = local.services.sa_region

  providers = {
    aws = aws.sa
  }

  certificate_arn = module.acm_sp.acm_certificate_arn
  vpc_id          = module.vpc_sp.vpc_id

  name              = each.value.name
  private_subnet_id = each.value.private_subnet
  public_subnet_id  = each.value.public_subnet
}

module "services_eu" {
  source   = "./service"
  for_each = local.services.eu_region

  providers = {
    aws = aws.eu
  }

  certificate_arn = module.acm_eu.acm_certificate_arn
  vpc_id          = module.vpc_eu.vpc_id

  name              = each.value.name
  private_subnet_id = each.value.private_subnet
  public_subnet_id  = each.value.public_subnet
}
