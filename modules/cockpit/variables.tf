variable "cockpit" {
  type = list(object({
    name                  = string
    region                = string
    enable_managed_alerts = optional(bool)
    contact_points = optional(list(object({
      email = string
    })))
    user = optional(list(object({
      login = string
      role  = string
    })))
    source = optional(list(object({
      retention_days = number
      type           = optional(string)
    })))
    token_scopes = optional(list(object({
      query_logs          = optional(bool)
      write_logs          = optional(bool)
      setup_logs_rules    = optional(bool)
      query_metrics       = optional(bool)
      write_metrics       = optional(bool)
      setup_metrics_rules = optional(bool)
      query_traces        = optional(bool)
      write_traces        = optional(bool)
      setup_alerts        = optional(bool)
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for source in var.cockpit.*.source : true if contains(["metrics", "logs", "traces"], source.type)])
    error_message = "Valid values are : metrics, logs or traces."
  }

  validation {
    condition     = alltrue([for role in var.cockpit.*.user : true if contains(["editor", "viewer"], role.role)])
    error_message = "Valid values are : editor or viewer."
  }

  validation {
    condition     = alltrue([for days in var.cockpit.*.source : true if days.retention_days >= 1 && days.retention_days <= 365])
    error_message = "Must be a value between 1 and 365."
  }
}