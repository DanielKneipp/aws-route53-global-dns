resource "aws_globalaccelerator_accelerator" "accelerator" {
  name            = "service-global-endpoint"
  ip_address_type = "IPV4"
  enabled         = true
}

resource "aws_globalaccelerator_listener" "tls" {
  accelerator_arn = aws_globalaccelerator_accelerator.accelerator.id
  client_affinity = "NONE"
  protocol        = "TCP"

  port_range {
    from_port = 443
    to_port   = 443
  }
}

resource "aws_globalaccelerator_endpoint_group" "eu" {
  listener_arn            = aws_globalaccelerator_listener.tls.id
  endpoint_group_region   = "eu-central-1"
  traffic_dial_percentage = 100

  endpoint_configuration {
    client_ip_preservation_enabled = false
    endpoint_id                    = module.services_eu["eu1"].nlb_arn
    weight                         = 255
  }
  endpoint_configuration {
    client_ip_preservation_enabled = false
    endpoint_id                    = module.services_eu["eu2"].nlb_arn
    weight                         = 1
  }
}

resource "aws_globalaccelerator_endpoint_group" "sa" {
  listener_arn            = aws_globalaccelerator_listener.tls.id
  endpoint_group_region   = "sa-east-1"
  traffic_dial_percentage = 100

  endpoint_configuration {
    client_ip_preservation_enabled = false
    endpoint_id                    = module.services_sa["sa1"].nlb_arn
    weight                         = 255
  }
  endpoint_configuration {
    client_ip_preservation_enabled = false
    endpoint_id                    = module.services_sa["sa2"].nlb_arn
    weight                         = 1
  }
}
