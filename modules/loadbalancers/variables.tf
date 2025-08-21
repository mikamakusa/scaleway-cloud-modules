variable "tags" {
  type    = list(string)
  default = []
}

variable "lb" {
  type = list(object({
    type                    = string
    assign_flexible_ip      = optional(bool)
    assign_flexible_ipv6    = optional(bool)
    description             = optional(string)
    ip_ids                  = optional(list(string))
    name                    = optional(string)
    ssl_compatibility_level = optional(string)
    tags                    = optional(list(string))
    is_ipv6                 = optional(bool)
    reverse                 = optional(string)
    ip = optional(list(object({
      is_ipv6 = optional(bool)
      reverse = optional(string)
    })))
    acl = optional(list(object({
      index       = number
      name        = optional(string)
      description = optional(string)
      action = optional(object({
        type = string
        redirect = optional(object({
          type   = optional(string)
          target = optional(string)
          code   = optional(number)
        }))
      }))
      match = optional(object({
        ip_subnet          = optional(list(string))
        http_filter        = optional(string)
        http_filter_option = optional(string)
        http_filter_value  = optional(list(string))
      }))
    })))
    frontend = optional(list(object({
      backend_id            = string
      inbound_port          = number
      lb_id                 = string
      name                  = optional(string)
      timeout_client        = optional(string)
      certificate_ids       = optional(list(string))
      enable_http3          = optional(bool)
      connection_rate_limit = optional(number)
    })))
    backend = optional(list(object({
      name                        = string
      forward_protocol            = string
      forward_port                = number
      server_ips                  = list(string)
      sticky_sessions             = optional(string)
      sticky_sessions_cookie_name = optional(string)
      proxy_protocol              = optional(string)
      timeout_connect             = optional(string)
      timeout_queue               = optional(string)
      timeout_server              = optional(string)
      timeout_tunnel              = optional(string)
      failover_host               = optional(string)
      forward_port_algorithm      = optional(string)
      ssl_bridging                = optional(bool)
      ignore_ssl_server_verify    = optional(bool)
      max_connections             = optional(number)
      max_retries                 = optional(number)
      redispatch_attempt_count    = optional(number)
    })))
    certificate = optional(list(object({
      lb_id = string
      name  = optional(string)
      letsencrypt = optional(object({
        common_name              = string
        subject_alternative_name = optional(list(string))
      }))
      custom_certificate = optional(object({
        certificate_chain = string
      }))
    })))
    route = optional(list(object({
      backend_id        = string
      frontend_id       = string
      match_subdomains  = optional(bool)
      match_sni         = optional(string)
      match_host_header = optional(string)
      match_path_begin  = optional(string)
    })))
  }))

  validation {
    condition     = alltrue([for a in var.lb : length(a.name) > 0])
    error_message = "Chaque load balancer doit avoir un nom."
  }

  validation {
    condition     = alltrue([for b in var.lb : contains(["allow", "deny", "redirect"], b.frontend.action.type)])
    error_message = "Les actions possible sont 'allow', 'deny' ou 'redirect."
  }

  validation {
    condition     = alltrue([for c in var.lb : contains(["301", "302", "303", "307", "308"], c.frontend.action.redirect.code)])
    error_message = "Les codes de retour possible sont 301, 302, 303, 307, 308."
  }

  validation {
    condition     = alltrue([for d in var.lb : contains(["tcp", "http"], d.backend.forward_protocol)])
    error_message = "Les valeurs possible pour ce champs sont tcp ou http."
  }

  validation {
    condition     = alltrue([for e in var.lb : contains(["roundrobin", "leastconn", "first"], e.backend.forward_port_algorithm)])
    error_message = "L'algorithme de Load Balancing est à choisir parmis 'roundrobin', 'leastconn' et 'first'."
  }

  validation {
    condition     = alltrue([for f in var.lb : contains(["none", "cookie", "table"], f.backend.sticky_sessions)])
    error_message = "Le type de sticky sessions est choisir parmis 'none', 'cookie' et 'table'."
  }
}