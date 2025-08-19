variable "project_name" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "api_key" {
  type = list(object({
    id                 = string
    description        = optional(string)
    application_id     = optional(string)
    user_id            = optional(string)
    expires_at         = optional(string)
  }))
  default = []
}

variable "ssh_key" {
  type = list(object({
    id         = string
    public_key = string
    name       = optional(string)
    disabled   = optional(bool)
  }))
  default = []
}

variable "application" {
  type = list(object({
    id              = string
    name            = optional(string)
    description     = optional(string)
    tags            = optional(list(string))
    organization_id = optional(string)
  }))
  default = []
}

variable "group" {
  type = list(object({
    id                  = string
    name                = string
    description         = optional(string)
    tags                = optional(list(string))
    application_ids     = optional(string)
    user_ids            = optional(string)
    external_membership = optional(bool)
    organization_id     = optional(string)
  }))
  default = []
}

variable "group_membership" {
  type = list(object({
    id             = string
    group_id       = string
    user_id        = optional(string)
    application_id = optional(string)
  }))
  default = []
}

variable "policy" {
  type = list(object({
    id             = string
    name           = optional(string)
    description    = optional(string)
    tags           = optional(list(string))
    no_principal   = optional(bool)
    application_id = optional(string)
    rule = optional(object({
      permission_set_names = optional(list(string))
      project_ids          = optional(list(string))
      organization_id      = optional(string)
      condition            = optional(string)
    }))
  }))
  default = []
}

variable "user" {
  type = list(object({
    id                  = string
    email               = string
    tags                = optional(list(string))
    username            = optional(string)
    password            = optional(string)
    phone_number        = optional(string)
    send_password_email = optional(bool)
    send_welcome_email  = optional(bool)
    first_name          = optional(string)
    last_name           = optional(string)
    locale              = optional(string)
  }))
  default = []
}
