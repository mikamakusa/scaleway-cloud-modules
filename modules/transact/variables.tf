variable "project_name" {
  type = string
}

variable "domains" {
  type = list(object({
    accept_tos = bool
    name       = string
    region     = optional(string)
    autoconfig = optional(bool)
    blocked_lists = optional(list(object({
      email  = string
      type   = string
      reason = optional(string)
    })))
    domain_validations = optional(list(object({
      timeout = optional(number)
    })))
    webhooks = optional(list(object({
      event_types = list(string)
      sns_arn     = string
      name        = optional(string)
    })))
  }))
}