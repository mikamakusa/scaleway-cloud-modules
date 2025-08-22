variable "tags" {
  type    = list(string)
  default = []
}

variable "project_name" {
  type = string
}

variable "region" {
  type    = string
  default = null
}

variable "vpc" {
  type = list(object({
    id                               = string
    name                             = optional(string)
    tags                             = optional(list(string))
    enable_routing                   = optional(bool)
    enable_custom_routes_propagation = optional(bool)
  }))
  default = []
}

variable "private_network" {
  type = list(object({
    id                               = string
    name                             = optional(string)
    tags                             = optional(list(string))
    vpc_id                           = optional(string)
    enable_default_route_propagation = optional(bool)
    ipv4_subnet                      = optional(string)
    ipv6_subnets = optional(list(object({
      subnet = string
    })))
  }))
  default = []
}

variable "acl" {
  type = list(object({
    id             = string
    default_policy = string
    vpc_id         = string
    is_ipv6        = optional(string)
    rules = optional(object({
      action        = optional(string)
      description   = optional(string)
      destination   = optional(string)
      dst_port_high = optional(number)
      dst_port_low  = optional(number)
      protocol      = optional(string)
      source        = optional(string)
      src_port_high = optional(number)
      src_port_low  = optional(number)
    }))
  }))
  default = []
}

variable "gateway_network" {
  type = list(object({
    id                 = string
    gateway_id         = string
    private_network_id = string
    enable_masquerade  = optional(bool)
    zone               = optional(string)
  }))
  default = []
}

variable "public_gateway" {
  type = list(object({
    type              = optional(string)
    name              = string
    tags              = optional(string)
    zone              = optional(string)
    ip_id             = optional(string)
    bastion_enabled   = optional(bool)
    bastion_port      = optional(string)
    allowed_ip_ranges = optional(string)
    enable_smtp       = optional(bool)
    refresh_ssh_keys  = optional(string)
  }))
  default = []
}

variable "public_gateway_dhcp" {
  type = list(object({
    subnet               = string
    address              = optional(string)
    dns_local_name       = optional(string)
    dns_search           = optional(list(string))
    dns_servers_override = optional(list(string))
    enable_dynamic       = optional(number)
    pool_high            = optional(string)
    pool_low             = optional(string)
    rebind_timer         = optional(number)
    renew_timer          = optional(number)
    valid_lifetime       = optional(number)
    zone                 = optional(string)
  }))
  default = []
}

variable "public_gateway_dhcp_reservation" {
  type = list(object({
    id                 = string
    gateway_network_id = string
    ip_address         = string
    mac_address        = string
    zone               = optional(string)
  }))
  default = []
}

variable "public_gateway_ip" {
  type = list(object({
    id      = string
    reverse = optional(string)
    tags    = optional(list(string))
    zone    = optional(string)
  }))
  default = []
}

variable "public_gateway_ip_reverse_dns" {
  type = list(object({
    id            = string
    gateway_ip_id = string
    reverse       = string
    zone          = optional(string)
  }))
  default = []
}

variable "public_gateway_pat_rule" {
  type = list(object({
    id           = string
    gateway_id   = string
    private_ip   = string
    private_port = number
    public_port  = number
    zone         = optional(string)
  }))
  default = []
}

variable "route" {
  type = list(object({
    id                         = string
    vpc_id                     = string
    description                = optional(string)
    tags                       = optional(string)
    destination                = optional(string)
    nexthop_resource_id        = optional(string)
    nexthop_private_network_id = optional(string)
  }))
  default = []
}
