variable "project_name" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "vpc" {
  type = object({
    name            = optional(string)
    is_default      = optional(bool)
    organization_id = optional(string)
  })
  default = null
}

variable "private_network" {
  type = object({
    name = optional(string)
  })
  default = null
}

variable "ips" {
  type = list(object({
    id      = string
    address = optional(string)
    tags    = optional(list(string))
    is_ipv6 = optional(bool)
    region  = optional(string)
    reverse_dns = optional(list(object({
      address  = string
      hostname = string
    })))
  }))
  default = []
}