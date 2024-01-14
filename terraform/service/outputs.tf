output "nlb_domain_name" {
  description = "NLB dns name"
  value       = module.nlb.dns_name
}

output "nlb_zone_id" {
  description = "NLB zone id"
  value       = module.nlb.zone_id
}
