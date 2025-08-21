variable "project_name" {
  type = string
}

variable "secret" {
  type = object({
    name            = optional(string)
    path            = optional(string)
    secret_id       = optional(string)
    organization_id = optional(string)
    region          = optional(string)
  })
  default = null
}

variable "job_definitions" {
  type = map(object({
    cpu_limit    = number
    memory_limit = number
    image_uri    = string
    description  = optional(string)
    command      = optional(string)
    timeout      = optional(string)
    env          = optional(map(string))
    region       = optional(string)
  }))
  default = {}
}

variable "cron" {
  type = object({
    schedule = string
    timezone = string
  })
  default = null
}

variable "secret_reference" {
  type = object({
    secret_version = optional(string)
    file           = optional(string)
    environment    = optional(string)
  })
  default = null
}