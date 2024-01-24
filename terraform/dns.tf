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

resource "aws_route53_record" "secondary" {
  zone_id = aws_route53_zone.main.id
  name    = local.domain_name
  type    = "A"

  alias {
    name                   = aws_globalaccelerator_accelerator.accelerator.dns_name
    zone_id                = aws_globalaccelerator_accelerator.accelerator.hosted_zone_id
    evaluate_target_health = false
  }
}
