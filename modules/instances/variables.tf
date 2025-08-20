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

variable "images" {
  type = list(object({
    id                    = string
    root_volume_id        = optional(string)
    additional_volume_ids = optional(string)
    architecture          = optional(string)
    name                  = optional(string)
    public                = optional(bool)
    tags                  = optional(list(string))
    zone                  = optional(string)
  }))
  default = []

  validation {
    condition     = alltrue([for image in var.images : true if contains(["x86_64", "arm"], image.architecture)])
    error_message = "Valid values are : x86_64 or arm."
  }
}

variable "ips" {
  type = list(object({
    type       = optional(string)
    zone       = optional(string)
    is_reverse = bool
    reverse    = optional(string)
  }))
  default = []
}

variable "placement_groups" {
  type = list(object({
    id          = string
    name        = string
    policy_mode = optional(string)
    policy_type = optional(string)
    zone        = optional(string)
    tags        = optional(list(string))
  }))
  default = []

  validation {
    condition     = alltrue([for policy in var.placement_groups : true if contains(["low_latency", "max_availability"], policy.policy_type)])
    error_message = "Valid values are : low_latency or max_availability."
  }

  validation {
    condition     = alltrue([for policy in var.placement_groups : true if contains(["optional", "enforced"], policy.policy_mode)])
    error_message = "Valid values are : optional or enforced."
  }
}

variable "private_nics" {
  type = list(object({
    server_id = string
    tags      = optional(list(string))
    zone      = optional(string)
  }))
  default = []
}

variable "security_groups" {
  type = list(object({
    id                      = string
    name                    = optional(string)
    description             = optional(string)
    inbound_default_policy  = optional(string)
    outbound_default_policy = optional(string)
    zone                    = optional(string)
    enable_default_security = optional(bool)
    stateful                = optional(bool)
    external_rules          = optional(bool)
  }))
  default = []

  validation {
    condition     = alltrue([for rule in var.security_groups : true if contains(["drop", "accept"], rule.inbound_default_policy)])
    error_message = "Valid values are : drop or accept."
  }

  validation {
    condition     = alltrue([for rule in var.security_groups : true if contains(["drop", "accept"], rule.outbound_default_policy)])
    error_message = "Valid values are : drop or accept."
  }
}

variable "rules" {
  type = list(object({
    id                = string
    security_group_id = string
  }))
  default = []
}

variable "inbound_rule" {
  type = list(object({
    action     = optional(string)
    port       = optional(number)
    port_range = optional(string)
    protocol   = optional(string)
    ip_range   = optional(string)
  }))
  default = []

  validation {
    condition     = alltrue([for rule in var.inbound_rule : true if contains(["TCP", "UDP", "ICMP", "ANY"], rule.protocol)])
    error_message = "Valid values are : TCP, UDP, ICMP, ANY."
  }

  validation {
    condition     = alltrue([for rule in var.inbound_rule : true if contains(["drop", "accept"], rule.action)])
    error_message = "Valid values are : drop or accept."
  }
}

variable "outbound_rule" {
  type = list(object({
    action     = optional(string)
    port       = optional(number)
    port_range = optional(string)
    protocol   = optional(string)
    ip_range   = optional(string)
  }))
  default = []

  validation {
    condition     = alltrue([for rule in var.outbound_rule : true if contains(["TCP", "UDP", "ICMP", "ANY"], rule.protocol)])
    error_message = "Valid values are : TCP, UDP, ICMP, ANY."
  }

  validation {
    condition     = alltrue([for rule in var.outbound_rule : true if contains(["drop", "accept"], rule.action)])
    error_message = "Valid values are : drop or accept."
  }
}

variable "servers" {
  type = list(object({
    id                     = string
    type                   = string
    image                  = optional(string)
    name                   = optional(string)
    tags                   = optional(list(string))
    security_group_id      = optional(string)
    placement_group_id     = optional(string)
    additional_volume_ids  = optional(string)
    enable_dynamic_ip      = optional(bool)
    ip_id                  = optional(string)
    ip_ids                 = optional(list(string))
    state                  = optional(string)
    boot_type              = optional(string)
    replace_on_type_change = optional(bool)
    protected              = optional(bool)
    zone                   = optional(string)
    root_volume = optional(list(object({
      volume_id   = optional(string)
      volume_type = optional(string)
      sbs_iops    = optional(number)
      size_in_gb  = optional(number)
    })))
  }))
  default = []
}

variable "snapshots" {
  type = list(object({
    id        = string
    volume_id = optional(string)
    type      = optional(string)
    name      = optional(string)
    zone      = optional(string)
    tags      = optional(list(string))
  }))
  default = []

  validation {
    condition     = alltrue([for snapshot in var.snapshots : true if contains(["l_ssd", "unified"], snapshot.type)])
    error_message = "Valid values are : l_ssd or unified."
  }
}

variable "user_data" {
  type = list(object({
    id        = string
    key       = string
    server_id = string
    value     = string
  }))
  default = []
}

variable "volumes" {
  type = list(object({
    type        = string
    size_in_gb  = optional(number)
    snapshot_id = optional(string)
    name        = optional(string)
    zone        = optional(string)
    tags        = optional(list(string))
  }))
  default = []

  validation {
    condition     = alltrue([for volume in var.volumes : true if contains(["l_ssd", "scratch"], volume.type)])
    error_message = "Valid values are : l_ssd or scratch."
  }
}