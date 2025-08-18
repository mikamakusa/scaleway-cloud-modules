variable "vpcs" {
  type = list(object({
    name                             = optional(string)
    tags                             = optional(list(string))
    enable_routing                   = optional(bool)
    enable_custom_routes_propagation = optional(bool)
    region                           = optional(string)
    private_network = optional(list(object({
      name                             = optional(string)
      tags                             = optional(list(string))
      region                           = optional(string)
      enable_default_route_propagation = optional(bool)
    })))
  }))
  default = []
}

variable "ipv4_subnet" {
  type    = string
  default = null
}

variable "ipv6_subnets" {
  type    = string
  default = null
}

variable "apple_silicon_servers" {
  type = list(object({
    type             = string
    name             = optional(string)
    zone             = optional(string)
    enable_vpc       = optional(bool)
  }))
  default = []
}