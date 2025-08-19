## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.59.0 |

## Modules

No modules.

## Usages

- [backend_stage](examples/backend_stage/main.tf)
- [cache_stage](examples/cache_stage/main.tf)
- [dns_stage](examples/dns_stage/main.tf)
- [route_stage](examples/route_stage/main.tf)
- [tls_stage](examples/tls_stage/main.tf)
- [waf_stage](examples/waf_stage/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_edge_services_backend_stage.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_backend_stage) | resource |
| [scaleway_edge_services_cache_stage.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_cache_stage) | resource |
| [scaleway_edge_services_dns_stage.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_dns_stage) | resource |
| [scaleway_edge_services_head_stage.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_head_stage) | resource |
| [scaleway_edge_services_pipeline.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_pipeline) | resource |
| [scaleway_edge_services_plan.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_plan) | resource |
| [scaleway_edge_services_route_stage.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_route_stage) | resource |
| [scaleway_edge_services_tls_stage.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_tls_stage) | resource |
| [scaleway_edge_services_waf_stage.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/edge_services_waf_stage) | resource |
| [scaleway_lb.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb) | resource |
| [scaleway_lb_backend.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_backend) | resource |
| [scaleway_lb_frontend.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_frontend) | resource |
| [scaleway_object_bucket.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/object_bucket) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backend_stage"></a> [backend\_stage](#input\_backend\_stage) | n/a | <pre>list(object({<br/>    id            = string<br/>    pipeline_id   = string<br/>    s3_backend_config = optional(list(object({<br/>      bucket_id = string<br/>    })))<br/>    lb_backend_config = optional(list(object({<br/>      lb_id       = optional(string)<br/>      is_ssl      = optional(bool)<br/>      domain_name = optional(string)<br/>      frontend_id = optional(string)<br/>      zone        = optional(string)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_bucket"></a> [bucket](#input\_bucket) | # AUTRES | <pre>list(object({<br/>    id   = string<br/>    name = string<br/>    tags = optional(map(string))<br/>  }))</pre> | n/a | yes |
| <a name="input_cache_stage"></a> [cache\_stage](#input\_cache\_stage) | n/a | <pre>list(object({<br/>    id               = string<br/>    pipeline_id      = string<br/>    backend_stage_id = optional(string)<br/>    route_stage_id   = optional(string)<br/>    waf_stage_id     = optional(string)<br/>    fallback_ttl     = optional(number)<br/>    refresh_cache    = optional(string)<br/>    purge_request = optional(list(object({<br/>      pipeline_id = optional(string)<br/>      assets      = optional(list(string))<br/>      all         = optional(bool)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_dns_stage"></a> [dns\_stage](#input\_dns\_stage) | n/a | <pre>list(object({<br/>    id               = string<br/>    pipeline_id      = string<br/>    backend_stage_id = optional(string)<br/>    tls_stage_id     = optional(string)<br/>    cache_stage_id   = optional(string)<br/>    fqdns            = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_head_stage"></a> [head\_stage](#input\_head\_stage) | n/a | <pre>list(object({<br/>    id            = string<br/>    pipeline_id   = string<br/>    head_stage_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_lb"></a> [lb](#input\_lb) | n/a | <pre>list(object({<br/>    id   = string<br/>    type = string<br/>  }))</pre> | `[]` | no |
| <a name="input_lb_backend"></a> [lb\_backend](#input\_lb\_backend) | n/a | <pre>list(object({<br/>    id               = string<br/>    forward_port     = number<br/>    forward_protocol = string<br/>    lb_id            = string<br/>  }))</pre> | `[]` | no |
| <a name="input_lb_frontend"></a> [lb\_frontend](#input\_lb\_frontend) | n/a | <pre>list(object({<br/>    id           = string<br/>    backend_id   = string<br/>    inbound_port = number<br/>    lb_id        = string<br/>  }))</pre> | `[]` | no |
| <a name="input_pipeline"></a> [pipeline](#input\_pipeline) | # EDGE | <pre>list(object({<br/>    id          = string<br/>    name        = optional(string)<br/>    description = optional(string)<br/>    plan        = bool<br/>  }))</pre> | `[]` | no |
| <a name="input_route_stage"></a> [route\_stage](#input\_route\_stage) | n/a | <pre>list(object({<br/>    id           = string<br/>    pipeline_id  = string<br/>    waf_stage_id = optional(string)<br/>    rule = optional(list(object({<br/>      backend_stage_id = string<br/>      method_filters = optional(list(string))<br/>      path_filter = optional(list(object({<br/>        path_filter_type = string<br/>        value            = string<br/>      })))<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | # TAGS | `map(string)` | `{}` | no |
| <a name="input_tls_stage"></a> [tls\_stage](#input\_tls\_stage) | n/a | <pre>list(object({<br/>    id                  = string<br/>    pipeline_id         = string<br/>    backend_stage_id    = optional(string)<br/>    cache_stage_id      = optional(string)<br/>    route_stage_id      = optional(string)<br/>    waf_stage_id        = optional(string)<br/>    managed_certificate = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_waf_stage"></a> [waf\_stage](#input\_waf\_stage) | n/a | <pre>list(object({<br/>    id               = string<br/>    paranoia_level   = number<br/>    pipeline_id      = string<br/>    backend_stage_id = optional(string)<br/>    mode             = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_backend_stage"></a> [backend\_stage](#output\_backend\_stage) | n/a |
| <a name="output_cache_stage"></a> [cache\_stage](#output\_cache\_stage) | n/a |
| <a name="output_dns_stage"></a> [dns\_stage](#output\_dns\_stage) | n/a |
| <a name="output_head_stage"></a> [head\_stage](#output\_head\_stage) | n/a |
| <a name="output_pipeline"></a> [pipeline](#output\_pipeline) | n/a |
| <a name="output_plan"></a> [plan](#output\_plan) | n/a |
| <a name="output_route_stage"></a> [route\_stage](#output\_route\_stage) | n/a |
| <a name="output_tls_stage"></a> [tls\_stage](#output\_tls\_stage) | n/a |
| <a name="output_waf_stage"></a> [waf\_stage](#output\_waf\_stage) | n/a |
