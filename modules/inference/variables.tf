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

variable "models" {
  type = list(object({
    name   = string
    url    = string
    secret = optional(string)
    region = optional(string)
    deployment = optional(list(object({
      node_type   = string
      name        = optional(string)
      accept_eula = optional(bool)
      tags        = optional(list(string))
      min_size    = optional(number)
      max_size    = optional(number)
      region      = optional(string)
    })))
  }))
  default = []
}

variable "private_endpoint" {
  type = list(object({
    disable_auth = optional(bool)
  }))
  default = []
}

variable "public_endpoint" {
  type = list(object({
    is_enabled = optional(bool)
    disable_auth = optional(bool)
  }))
  default = []
}