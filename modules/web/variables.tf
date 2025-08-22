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

variable "webhosting_offer" {
  type = object({
    name          = optional(string)
    control_panel = optional(string)
    offer_id      = optional(string)
  })
}

variable "webhosting" {
  type = list(object({
    domain     = string
    email      = string
    option_ids = optional(list(string))
    tags       = optional(list(string))
  }))
  default = []
}