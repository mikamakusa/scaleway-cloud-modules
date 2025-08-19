variable "project_name" {
  type = string
}

variable "vpcs" {
  type = list(object({
    name                             = optional(string)
    tags                             = optional(list(string))
    enable_routing                   = optional(bool)
    enable_custom_routes_propagation = optional(bool)
    region                           = optional(string)
    private_network = optional(list(object({
      name                             = optional(string)
      tags                             = optional(list(string))
      region                           = optional(string)
      enable_default_route_propagation = optional(bool)
    })))
  }))
  default = []
}

variable "ipv4_subnet" {
  type    = string
  default = null
}

variable "ipv6_subnets" {
  type    = string
  default = null
}

variable "block_volumes" {
  type = list(object({
    iops       = number
    size_in_gb = number
    name       = optional(string)
    tags       = optional(list(string))
    zone       = optional(string)
    snapshots = optional(list(object({
      name = string
      zone = optional(string)
      tags = optional(list(string))
    })))
  }))
  default = []
}

variable "lb_ips" {
  type = list(object({
    id      = string
    zone    = optional(string)
    reverse = optional(string)
    tags    = optional(list(string))
    is_ipv6 = optional(bool)
  }))
  default = []
}

variable "lbs" {
  type = list(object({
    id                      = string
    ip_ids                  = string
    type                    = string
    assign_flexible_ip      = optional(bool)
    assign_flexible_ipv6    = optional(bool)
    name                    = string
    description             = optional(string)
    tags                    = optional(list(string))
    ssl_compatibility_level = optional(string)
    zone                    = optional(string)
  }))
  default = []
}

variable "backends" {
  type = list(object({
    id                           = string
    lb_id                        = string
    forward_protocol             = string
    forward_port                 = number
    proxy_protocol               = string
    name                         = string
    forward_port_algorithm       = optional(string)
    failover_host                = optional(string)
    health_check_delay           = optional(string)
    health_check_max_retries     = optional(number)
    health_check_port            = optional(number)
    health_check_send_proxy      = optional(bool)
    health_check_timeout         = optional(string)
    health_check_transient_delay = optional(string)
    ignore_ssl_server_verify     = optional(bool)
    max_connections              = optional(number)
    max_retries                  = optional(number)
    on_marked_down_action        = optional(string)
    redispatch_attempt_count     = optional(number)
    server_ips                   = optional(list(string))
    ssl_bridging                 = optional(bool)
    sticky_sessions              = optional(string)
    sticky_sessions_cookie_name  = optional(string)
    timeout_connect              = optional(string)
    timeout_server               = optional(string)
    timeout_queue                = optional(string)
    timeout_tunnel               = optional(string)
    health_check_tcp             = optional(bool)
    health_check_http = optional(list(object({
      uri         = string
      method      = optional(string)
      code        = optional(number)
      host_header = optional(string)
    })))
    health_check_https = optional(list(object({
      uri         = string
      method      = optional(string)
      code        = optional(number)
      host_header = optional(string)
      sni         = optional(string)
    })))
  }))
  default = []
}

variable "instance_templates" {
  type = list(object({
    commercial_type     = string
    tags                = optional(list(string))
    name                = optional(string)
    image_id            = optional(string)
    security_group_id   = optional(string)
    placement_group_id  = optional(string)
    public_ips_v4_count = optional(string)
    public_ips_v6_count = optional(string)
    cloud_init          = optional(string)
    zone                = optional(string)
    instance_groups = optional(list(object({
      name                      = string
      tags                      = optional(list(string))
      delete_servers_on_destroy = optional(bool)
      zone                      = optional(string)
      max_replicas              = optional(number)
      min_replicas              = optional(number)
      cooldown_delay            = optional(string)
      lb_name                   = optional(string)
      private_network_name      = optional(string)
    })))
    instance_policies = optional(list(object({
      name                      = optional(string)
      action                    = string
      type                      = string
      value                     = number
      priority                  = number
      zone                      = optional(string)
      metric_name               = string
      metric_managed_metric     = string
      metric_operator           = string
      metric_aggregate          = string
      metric_sampling_range_min = number
      metric_threshold          = number
    })))
  }))
  default = []
}

variable "volumes" {
  type = list(object({
    name        = string
    perf_iops   = number
    tags        = list(string)
    boot        = bool
    volume_type = string
  }))
  default = []
}