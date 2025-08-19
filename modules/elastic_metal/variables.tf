## DATAS
variable "project_name" {
  type = string
}

variable "os" {
  type = object({
    zone    = optional(string)
    name    = optional(string)
    version = optional(string)
    os_id   = optional(string)
  })
  default = null
}

variable "offer" {
  type = object({
    name                = optional(string)
    subscription_period = optional(string)
    offer_id            = optional(string)
    zone                = optional(string)
    include_disabled    = optional(bool)
  })
  default = null
}

variable "ssh_key" {
  type = object({
    name       = optional(string)
    ssh_key_id = optional(string)
  })
  default = null
}

variable "option" {
  type = list(object({
    id        = string
    name      = optional(string)
    option_id = optional(string)
    zone      = optional(string)
  }))
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

## RESOURCES
variable "servers" {
  type = list(object({
    offer                       = string
    os                          = optional(string)
    ssh_key_ids                 = optional(string)
    user                        = optional(string)
    password                    = optional(string)
    service_password            = optional(string)
    service_user                = optional(string)
    reinstall_on_config_changes = optional(bool)
    install_config_afterward    = optional(bool)
    name                        = optional(string)
    hostname                    = optional(string)
    description                 = optional(string)
    tags                        = optional(list(string))
    zone                        = optional(string)
    partitioning                = optional(string)
    protected                   = optional(bool)
    id                          = optional(string)
    options = optional(list(object({
      option_id  = string
      expirez_at = optional(string)
    })))
  }))
  default = []
}

variable "flexible_ips" {
  type = list(object({
    description = optional(string)
    tags        = optional(list(string))
    reverse     = optional(string)
    is_ipv6     = optional(bool)
    zone        = optional(string)
    server_id   = optional(string)
    mac_addresses = optional(list(object({
      type = optional(string)
    })))
  }))
  default = []
}