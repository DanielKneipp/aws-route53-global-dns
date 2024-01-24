# certificate
module "acm_sa" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  providers = {
    aws = aws.sa
  }

  domain_name = local.domain_name
  zone_id     = aws_route53_zone.main.id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${local.domain_name}",
  ]

  wait_for_validation = true
}

module "acm_eu" {
  source  = "terraform-aws-modules/acm/aws"
  version = "~> 4.0"

  providers = {
    aws = aws.eu
  }

  domain_name = local.domain_name
  zone_id     = aws_route53_zone.main.id

  validation_method = "DNS"

  subject_alternative_names = [
    "*.${local.domain_name}",
  ]

  wait_for_validation = false
}
