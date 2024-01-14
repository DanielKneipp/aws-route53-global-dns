# NLB
module "nlb" {
  source = "terraform-aws-modules/alb/aws"

  name                             = "${var.name}-nlb"
  load_balancer_type               = "network"
  vpc_id                           = var.vpc_id
  subnets                          = [var.public_subnet_id]
  enable_deletion_protection       = false
  enable_cross_zone_load_balancing = false

  # Security Group
  enforce_security_group_inbound_rules_on_private_link_traffic = "on"
  security_group_ingress_rules = {
    all_https = {
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      description = "HTTPS web traffic"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    tcp_ephemeral = {
      from_port   = 1024
      to_port     = 65535
      ip_protocol = "tcp"
      description = "Respond to requests"
      cidr_ipv4   = "0.0.0.0/0"
    }
    ec2_traffic = {
      from_port                    = 80
      to_port                      = 80
      ip_protocol                  = "tcp"
      description                  = "Communicate with EC2 instance"
      referenced_security_group_id = module.web_server_sg.security_group_id
    }
  }

  listeners = {
    ex-tls = {
      port            = 443
      protocol        = "TLS"
      certificate_arn = var.certificate_arn
      forward = {
        target_group_key = "http"
      }
    }
  }

  target_groups = {
    http = {
      name_prefix       = "http-"
      protocol          = "TCP"
      port              = 80
      target_type       = "instance"
      create_attachment = true
      target_id         = module.ec2_instance.id

      health_check = {
        enabled             = true
        interval            = 5
        path                = "/index.html"
        port                = "traffic-port"
        healthy_threshold   = 2
        unhealthy_threshold = 2
        timeout             = 3
        protocol            = "HTTP"
        matcher             = "200"
      }
    }
  }
}
