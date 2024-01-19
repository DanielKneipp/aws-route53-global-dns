module "vpc_sa" {
  providers = {
    aws = aws.sa
  }

  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-sa"
  cidr = "10.0.0.0/16"

  azs             = ["sa-east-1a", "sa-east-1b"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = true
}
module "vpc_eu" {
  providers = {
    aws = aws.eu
  }

  source = "terraform-aws-modules/vpc/aws"

  name = "vpc-eu"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = true
}
