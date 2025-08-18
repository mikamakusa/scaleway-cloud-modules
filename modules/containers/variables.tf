variable "namespaces" {
  type = list(object({
    name                         = string
    description                  = optional(string)
    tags                         = optional(list(string))
    region                       = optional(string)
    environment_variables        = optional(map(string))
    secret_environment_variables = optional(map(string))
    activate_vpc_integration     = optional(bool)
    containers = optional(list(object({
      name                = string
      description         = optional(string)
      min_scale           = optional(number)
      max_scale           = optional(number)
      memory_limit        = optional(number)
      cpu_limit           = optional(number)
      timeout             = optional(number)
      privacy             = optional(string)
      registry_image      = optional(string)
      registry_sha256     = optional(string)
      protocol            = optional(string)
      http_option         = optional(string)
      sandbox             = optional(string)
      port                = optional(number)
      deploy              = optional(bool)
      local_storage_limit = optional(number)
      command             = optional(list(string))
      args                = optional(list(string))
      cron = optional(list(object({
        args     = string
        schedule = string
        name     = optional(string)
      })))
      domain = optional(list(object({
        hostname = string
      })))
      trigger = optional(list(object({
        name        = optional(string)
        description = optional(string)
        region      = optional(string)
      })))
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for option in var.namespaces.*.containers : true if contains(["enabled", "redirected"], option.http_option)])
    error_message = "Valid values are : redirected or enabled."
  }

  validation {
    condition     = alltrue([for option in var.namespaces.*.containers : true if contains(["http1", "h2c"], option.protocol)])
    error_message = "Valid values are : http1 or h2c."
  }
}

variable "health_check" {
  type = list(object({
    failure_threshold = number
    interval          = string
    http_path         = optional(string)
  }))
  default = []
}

variable "scaling_option" {
  type = list(object({
    concurrent_requests_threshold = optional(number)
    cpu_usage_threshold           = optional(number)
    memory_usage_threshold        = optional(number)
  }))
  default = []
}

variable "tokens" {
  type = list(object({
    container_name = string
    namespace_name = string
    description    = optional(string)
    expires_at     = optional(string)
    region         = optional(string)
  }))
  default = []
}