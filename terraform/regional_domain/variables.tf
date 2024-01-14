variable "route53_zone_id" {
  type        = string
  description = "Route53 zone id"
}

variable "elb_target_primary" {
  type = object({
    domain_name = string
    zone_id     = string
  })
  description = "Primary ELB target specs"
}

variable "elb_target_secondary" {
  type = object({
    domain_name = string
    zone_id     = string
  })
  description = "Secondary ELB target specs"
}
