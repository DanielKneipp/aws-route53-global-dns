resource "aws_route53_record" "main" {
  zone_id = var.route53_zone_id
  name    = "www.${data.aws_route53_zone.selected.name}"
  type    = "CNAME"
  ttl     = 300
  records = ["${data.aws_region.current.name}.${data.aws_route53_zone.selected.name}"]

  latency_routing_policy {
    region = data.aws_region.current.name
  }

  set_identifier = "${data.aws_region.current.name}.${data.aws_route53_zone.selected.name}"
}

resource "aws_route53_record" "primary" {
  zone_id = var.route53_zone_id
  name    = "${data.aws_region.current.name}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  failover_routing_policy {
    type = "PRIMARY"
  }

  alias {
    name                   = var.elb_target_primary.domain_name
    zone_id                = var.elb_target_primary.zone_id
    evaluate_target_health = true
  }

  set_identifier = "primary.${data.aws_region.current.name}.${data.aws_route53_zone.selected.name}"
}

resource "aws_route53_record" "secondary" {
  zone_id = var.route53_zone_id
  name    = "${data.aws_region.current.name}.${data.aws_route53_zone.selected.name}"
  type    = "A"

  failover_routing_policy {
    type = "SECONDARY"
  }

  alias {
    name                   = var.elb_target_secondary.domain_name
    zone_id                = var.elb_target_secondary.zone_id
    evaluate_target_health = true
  }

  set_identifier = "secondary.${data.aws_region.current.name}.${data.aws_route53_zone.selected.name}"
}
