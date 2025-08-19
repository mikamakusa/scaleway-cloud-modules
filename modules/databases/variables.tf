variable "project_name" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "instance" {
  type = list(object({
    engine                    = string
    node_type                 = string
    volume_type               = optional(string)
    volume_size_in_gb         = optional(number)
    user_name                 = optional(string)
    password                  = optional(string)
    is_ha_cluster             = optional(bool)
    name                      = optional(string)
    tags                      = optional(list(string))
    region                    = optional(string)
    project_id                = optional(string)
    encryption_at_rest        = optional(bool)
    backup_same_region        = optional(bool)
    backup_schedule_frequency = optional(number)
    backup_schedule_retention = optional(number)
    disable_backup            = optional(bool)
    settings                  = optional(map(string))
    init_settings             = optional(map(string))
    database_backup = optional(list(object({
      database_name = string
      instance_id   = string
      expires_at    = optional(string)
    })))
    privilege = optional(list(object({
      permission = string
      user_name  = string
    })))
    read_replica = optional(list(object({
      same_zone     = optional(bool)
    })))
    user = optional(list(object({
      name     = string
      password = string
      is_admin = optional(string)
    })))
    acl = optional(list(object({
      ip          = string
      description = optional(string)
    })))
  }))
}