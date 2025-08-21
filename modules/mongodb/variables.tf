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

variable "instance" {
  type = list(object({
    node_number        = number
    node_type          = string
    name               = string
    version            = optional(string)
    user_name          = optional(string)
    password           = optional(string)
    tags               = optional(list(string))
    volume_type        = optional(string)
    volume_size_in_gb  = optional(number)
    snapshot = optional(list(object({
      expires_at = string
      name       = optional(string)
      region     = optional(string)
    })))
  }))
}