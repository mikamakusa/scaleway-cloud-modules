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

variable "clusters" {
  type = list(object({
    cni                         = string
    delete_additional_resources = bool
    name                        = string
    version                     = string
    type                        = optional(string)
    description                 = optional(string)
    tags                        = optional(list(string))
    feature_gates               = optional(list(string))
    admission_plugins           = optional(list(string))
    apiserver_cert_sans         = optional(list(string))
    region                      = optional(string)
    acls = optional(list(object({
      no_ip_allowed = optional(bool)
    })))
    pools = optional(list(object({
      name                   = string
      node_type              = string
      size                   = number
      min_size               = optional(number)
      max_size               = optional(number)
      autohealing            = optional(bool)
      autoscaling            = optional(bool)
      placement_group_id     = optional(string)
      container_runtime      = optional(string)
      kubelet_args           = optional(map(string))
      root_volume_size_in_gb = optional(number)
      root_volume_type       = optional(string)
      zone                   = optional(string)
      wait_for_pool_ready    = optional(bool)
      public_ip_disabled     = optional(bool)
      max_surge              = optional(number)
      max_unavailable        = optional(number)
    })))
  }))
  default = []

  validation {
    condition = alltrue([for type in var.clusters : true if contains(["kapsule", "multicloud", "kapsule-dedicated-4", "kapsule-dedicated-8", "kapsule-dedicated-16", "multicloud-dedicated-4", "multicloud-dedicated-8", "multicloud-dedicated-16"],type.type)])
    error_message = <<EOF
Possible values are:
- for mutualized clusters: kapsule or multicloud
- for dedicated Kapsule clusters: kapsule-dedicated-4, kapsule-dedicated-8 or kapsule-dedicated-16.
- for dedicated Kosmos clusters: multicloud-dedicated-4, multicloud-dedicated-8 or multicloud-dedicated-16.
    EOF
  }
}

variable "acl_rules" {
  type = list(object({
    description     = optional(string)
    ip              = optional(string)
    scaleway_ranges = optional(bool)
  }))
  default = []
}

variable "auto_upgrade" {
  type = object({
    enable                        = bool
    maintenance_window_day        = string
    maintenance_window_start_hour = number
  })
  default = null
}

variable "autoscaler_config" {
  type = object({
    scale_down_delay_after_add       = optional(string)
    scale_down_unneeded_time         = optional(string)
    estimator                        = optional(string)
    expander                         = optional(string)
    disable_scale_down               = optional(bool)
    ignore_daemonsets_utilization    = optional(bool)
    balance_similar_node_groups      = optional(bool)
    expendable_pods_priority_cutoff  = optional(number)
    max_graceful_termination_sec     = optional(number)
    scale_down_utilization_threshold = optional(number)
  })
  default = null
}