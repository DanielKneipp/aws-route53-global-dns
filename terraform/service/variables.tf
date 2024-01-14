variable "name" {
  type        = string
  description = "Service name"
}

variable "certificate_arn" {
  type        = string
  description = "ARN of the TLS certificate"
}

variable "vpc_id" {
  type        = string
  description = "VPC id"
}

variable "private_subnet_id" {
  type        = string
  description = "Private subnet ID"
}

variable "public_subnet_id" {
  type        = string
  description = "Public subnet ID"
}
