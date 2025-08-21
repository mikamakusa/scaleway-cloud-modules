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

variable "clusters" {
  type = map(object({
    node_type    = string
    password     = string
    user_name    = string
    version      = string
    tags         = optional(list(string))
    zone         = optional(string)
    cluster_size = optional(number)
    tls_enabled  = optional(bool)
    settings     = optional(map(string))
  }))
  default = {}
}

variable "acls" {
  type = list(object({
    ip          = string
    description = optional(string)
  }))
  default = []
}