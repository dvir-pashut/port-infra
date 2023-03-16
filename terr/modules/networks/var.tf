variable "region" {
  description = "region"
}

variable "vpc" {
  type = object({
    name                    = string
    auto_create_subnetworks = string
    routing_mode            = string
  })
  description = "vpc values"
}

variable "subnet" {
  type = object({
    name          = string
    ip_cidr_range = string
  })
  description = "subnets values"
}

variable "firewall" {
  type = object({
    name          = string
    protocol      = string
    ports         = list(string)
    source_ranges = list(string)
  })
}