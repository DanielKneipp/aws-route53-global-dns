# SG
module "web_server_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.name}-instance-sg"
  description = "Security group for web-server with HTTP ports open to NLB"
  vpc_id      = var.vpc_id

  egress_rules = ["https-443-tcp"]

  computed_ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.nlb.security_group_id
    },
  ]
  number_of_computed_ingress_with_source_security_group_id = 1

  computed_egress_with_source_security_group_id = [
    {
      from_port                = 1024
      to_port                  = 65535
      protocol                 = "tcp"
      description              = "Response to NLB"
      source_security_group_id = module.nlb.security_group_id
    },
  ]
  number_of_computed_egress_with_source_security_group_id = 1
}

# EC2
module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name = "${var.name}-instance"

  instance_type          = "t3.micro"
  monitoring             = true
  vpc_security_group_ids = [module.web_server_sg.security_group_id]
  subnet_id              = var.private_subnet_id

  create_iam_instance_profile = true
  iam_role_description        = "IAM role for EC2 web server"
  iam_role_policies = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  }

  user_data_base64 = base64encode(templatefile(
    "${path.module}/user_data.sh",
    { service_name = var.name }
  ))
}
