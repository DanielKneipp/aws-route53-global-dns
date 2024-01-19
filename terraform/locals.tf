locals {
  domain_name = "service.dkneipp.com"

  services = {
    sa_region = {
      sa1 = {
        name           = "sa1-service"
        private_subnet = module.vpc_sa.private_subnets[0]
        public_subnet  = module.vpc_sa.public_subnets[0]
      }
      sa2 = {
        name           = "sa2-service"
        private_subnet = module.vpc_sa.private_subnets[1]
        public_subnet  = module.vpc_sa.public_subnets[1]
      }
    }
    eu_region = {
      eu1 = {
        name           = "eu1-service"
        private_subnet = module.vpc_eu.private_subnets[0]
        public_subnet  = module.vpc_eu.public_subnets[0]
      }
      eu2 = {
        name           = "eu2-service"
        private_subnet = module.vpc_eu.private_subnets[1]
        public_subnet  = module.vpc_eu.public_subnets[1]
      }
    }
  }
}
