# hosted zone
resource "aws_route53_zone" "main" {
  name = local.domain_name
}

module "dns_sa" {
  source = "./regional_domain"

  providers = {
    aws = aws.sa
  }

  route53_zone_id = aws_route53_zone.main.id

  elb_target_primary = {
    domain_name = module.services_sa["sa1"].nlb_domain_name
    zone_id     = module.services_sa["sa1"].nlb_zone_id
  }

  elb_target_secondary = {
    domain_name = module.services_sa["sa2"].nlb_domain_name
    zone_id     = module.services_sa["sa2"].nlb_zone_id
  }
}

module "dns_eu" {
  source = "./regional_domain"

  providers = {
    aws = aws.eu
  }

  route53_zone_id = aws_route53_zone.main.id

  elb_target_primary = {
    domain_name = module.services_eu["eu1"].nlb_domain_name
    zone_id     = module.services_eu["eu1"].nlb_zone_id
  }

  elb_target_secondary = {
    domain_name = module.services_eu["eu2"].nlb_domain_name
    zone_id     = module.services_eu["eu2"].nlb_zone_id
  }
}
