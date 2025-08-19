variable "project_name" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "function" {
  type = list(object({
    handler                      = string
    privacy                      = string
    runtime                      = string
    name                         = string
    namespace_name               = optional(string)
    description                  = optional(string)
    region                       = optional(string)
    environment_variables        = optional(map(string))
    secret_environment_variables = optional(map(string))
    min_scale                    = optional(number)
    max_scale                    = optional(number)
    memory_limit                 = optional(number)
    zip_file                     = optional(string)
    deploy                       = optional(bool)
    http_option                  = optional(string)
    sandbox                      = optional(string)
    tags                         = optional(list(string))
    activate_vpc_integration     = optional(bool)
    args                         = optional(string)
    schedule                     = optional(string)
    hostname                     = optional(string)
    expires_at                   = optional(string)
  }))

  validation {
    condition     = alltrue([for a in var.function : contains(["enabled", "restricted"])])
    error_message = "Valid values are 'enabled' or 'restricted'."
  }
}