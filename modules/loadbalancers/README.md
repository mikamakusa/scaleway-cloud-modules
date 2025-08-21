## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [scaleway_lb.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/lb) | resource |
| [scaleway_lb_acl.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/lb_acl) | resource |
| [scaleway_lb_backend.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/lb_backend) | resource |
| [scaleway_lb_certificate.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/lb_certificate) | resource |
| [scaleway_lb_frontend.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/lb_frontend) | resource |
| [scaleway_lb_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/lb_ip) | resource |
| [scaleway_lb_route.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/lb_route) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_lb"></a> [lb](#input\_lb) | n/a | <pre>list(object({<br/>    type                    = string<br/>    assign_flexible_ip      = optional(bool)<br/>    assign_flexible_ipv6    = optional(bool)<br/>    description             = optional(string)<br/>    ip_ids                  = optional(list(string))<br/>    name                    = optional(string)<br/>    ssl_compatibility_level = optional(string)<br/>    tags                    = optional(list(string))<br/>    is_ipv6                 = optional(bool)<br/>    reverse                 = optional(string)<br/>    ip = optional(list(object({<br/>      is_ipv6 = optional(bool)<br/>      reverse = optional(string)<br/>    })))<br/>    acl = optional(list(object({<br/>      index       = number<br/>      name        = optional(string)<br/>      description = optional(string)<br/>      action = optional(object({<br/>        type = string<br/>        redirect = optional(object({<br/>          type   = optional(string)<br/>          target = optional(string)<br/>          code   = optional(number)<br/>        }))<br/>      }))<br/>      match = optional(object({<br/>        ip_subnet          = optional(list(string))<br/>        http_filter        = optional(string)<br/>        http_filter_option = optional(string)<br/>        http_filter_value  = optional(list(string))<br/>      }))<br/>    })))<br/>    frontend = optional(list(object({<br/>      backend_id            = string<br/>      inbound_port          = number<br/>      lb_id                 = string<br/>      name                  = optional(string)<br/>      timeout_client        = optional(string)<br/>      certificate_ids       = optional(list(string))<br/>      enable_http3          = optional(bool)<br/>      connection_rate_limit = optional(number)<br/>    })))<br/>    backend = optional(list(object({<br/>      name                        = string<br/>      forward_protocol            = string<br/>      forward_port                = number<br/>      server_ips                  = list(string)<br/>      sticky_sessions             = optional(string)<br/>      sticky_sessions_cookie_name = optional(string)<br/>      proxy_protocol              = optional(string)<br/>      timeout_connect             = optional(string)<br/>      timeout_queue               = optional(string)<br/>      timeout_server              = optional(string)<br/>      timeout_tunnel              = optional(string)<br/>      failover_host               = optional(string)<br/>      forward_port_algorithm      = optional(string)<br/>      ssl_bridging                = optional(bool)<br/>      ignore_ssl_server_verify    = optional(bool)<br/>      max_connections             = optional(number)<br/>      max_retries                 = optional(number)<br/>      redispatch_attempt_count    = optional(number)<br/>    })))<br/>    certificate = optional(list(object({<br/>      lb_id = string<br/>      name  = optional(string)<br/>      letsencrypt = optional(object({<br/>        common_name              = string<br/>        subject_alternative_name = optional(list(string))<br/>      }))<br/>      custom_certificate = optional(object({<br/>        certificate_chain = string<br/>      }))<br/>    })))<br/>    route = optional(list(object({<br/>      backend_id        = string<br/>      frontend_id       = string<br/>      match_subdomains  = optional(bool)<br/>      match_sni         = optional(string)<br/>      match_host_header = optional(string)<br/>      match_path_begin  = optional(string)<br/>    })))<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backends"></a> [backends](#output\_backends) | Informations sur les backends créés. |
| <a name="output_certificates"></a> [certificates](#output\_certificates) | Informations relatives au(x) certificat(s) lié(s) au Load Balancer. |
| <a name="output_frontends"></a> [frontends](#output\_frontends) | Informations sur les frontends créés. |
| <a name="output_ips"></a> [ips](#output\_ips) | IPs réservées pour les load balancers. |
| <a name="output_load_balancers"></a> [load\_balancers](#output\_load\_balancers) | Informations sur les load balancers créés. |
| <a name="output_routes"></a> [routes](#output\_routes) | Informations relatives au(x) routes entre le backend et le frontend au sein du Load Balancer. |
