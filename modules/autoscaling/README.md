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

## Usage

- [autoscaling](example/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_autoscaling_instance_group.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/autoscaling_instance_group) | resource |
| [scaleway_autoscaling_instance_policy.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/autoscaling_instance_policy) | resource |
| [scaleway_autoscaling_instance_template.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/autoscaling_instance_template) | resource |
| [scaleway_block_snapshot.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/block_snapshot) | resource |
| [scaleway_block_volume.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/block_volume) | resource |
| [scaleway_lb.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb) | resource |
| [scaleway_lb_backend.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_backend) | resource |
| [scaleway_lb_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/lb_ip) | resource |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc) | resource |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_private_network) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_backends"></a> [backends](#input\_backends) | n/a | <pre>list(object({<br/>    id                           = string<br/>    lb_id                        = string<br/>    forward_protocol             = string<br/>    forward_port                 = number<br/>    proxy_protocol               = string<br/>    name                         = optional(string)<br/>    forward_port_algorithm       = optional(string)<br/>    failover_host                = optional(string)<br/>    health_check_delay           = optional(string)<br/>    health_check_max_retries     = optional(number)<br/>    health_check_port            = optional(number)<br/>    health_check_send_proxy      = optional(bool)<br/>    health_check_timeout         = optional(string)<br/>    health_check_transient_delay = optional(string)<br/>    ignore_ssl_server_verify     = optional(bool)<br/>    max_connections              = optional(number)<br/>    max_retries                  = optional(number)<br/>    on_marked_down_action        = optional(string)<br/>    redispatch_attempt_count     = optional(number)<br/>    server_ips                   = optional(list(string))<br/>    ssl_bridging                 = optional(bool)<br/>    sticky_sessions              = optional(string)<br/>    sticky_sessions_cookie_name  = optional(string)<br/>    timeout_connect              = optional(string)<br/>    timeout_server               = optional(string)<br/>    timeout_queue                = optional(string)<br/>    timeout_tunnel               = optional(string)<br/>    health_check_tcp             = optional(bool)<br/>    health_check_http = optional(list(object({<br/>      uri         = string<br/>      method      = optional(string)<br/>      code        = optional(number)<br/>      host_header = optional(string)<br/>    })))<br/>    health_check_https = optional(list(object({<br/>      uri         = string<br/>      method      = optional(string)<br/>      code        = optional(number)<br/>      host_header = optional(string)<br/>      sni         = optional(string)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_block_volumes"></a> [block\_volumes](#input\_block\_volumes) | n/a | <pre>list(object({<br/>    iops       = number<br/>    size_in_gb = number<br/>    name       = optional(string)<br/>    tags       = optional(list(string))<br/>    zone       = optional(string)<br/>    snapshots = optional(list(object({<br/>      name = string<br/>      zone = optional(string)<br/>      tags = optional(list(string))<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_instance_templates"></a> [instance\_templates](#input\_instance\_templates) | n/a | <pre>list(object({<br/>    commercial_type     = string<br/>    tags                = optional(list(string))<br/>    name                = optional(string)<br/>    image_id            = optional(string)<br/>    security_group_id   = optional(string)<br/>    placement_group_id  = optional(string)<br/>    public_ips_v4_count = optional(string)<br/>    public_ips_v6_count = optional(string)<br/>    cloud_init          = optional(string)<br/>    zone                = optional(string)<br/>    instance_groups = optional(list(object({<br/>      name                      = string<br/>      tags                      = optional(list(string))<br/>      delete_servers_on_destroy = optional(bool)<br/>      zone                      = optional(string)<br/>      max_replicas              = optional(number)<br/>      min_replicas              = optional(number)<br/>      cooldown_delay            = optional(string)<br/>      lb_name                   = optional(string)<br/>      private_network_name      = optional(string)<br/>    })))<br/>    instance_policies = optional(list(object({<br/>      name                      = optional(string)<br/>      action                    = string<br/>      type                      = string<br/>      value                     = number<br/>      priority                  = number<br/>      zone                      = optional(string)<br/>      metric_name               = string<br/>      metric_managed_metric     = string<br/>      metric_operator           = string<br/>      metric_aggregate          = string<br/>      metric_sampling_range_min = number<br/>      metric_threshold          = number<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_ipv4_subnet"></a> [ipv4\_subnet](#input\_ipv4\_subnet) | n/a | `string` | `null` | no |
| <a name="input_ipv6_subnets"></a> [ipv6\_subnets](#input\_ipv6\_subnets) | n/a | `string` | `null` | no |
| <a name="input_lb_ips"></a> [lb\_ips](#input\_lb\_ips) | n/a | <pre>list(object({<br/>    id      = string<br/>    zone    = optional(string)<br/>    reverse = optional(string)<br/>    tags    = optional(list(string))<br/>    is_ipv6 = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_lbs"></a> [lbs](#input\_lbs) | n/a | <pre>list(object({<br/>    id                      = string<br/>    ip_ids                  = string<br/>    type                    = string<br/>    assign_flexible_ip      = optional(bool)<br/>    assign_flexible_ipv6    = optional(bool)<br/>    name                    = optional(string)<br/>    description             = optional(string)<br/>    tags                    = optional(list(string))<br/>    ssl_compatibility_level = optional(string)<br/>    zone                    = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | n/a | <pre>list(object({<br/>    name        = string<br/>    perf_iops   = number<br/>    tags        = list(string)<br/>    boot        = bool<br/>    volume_type = string<br/>  }))</pre> | `[]` | no |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | n/a | <pre>list(object({<br/>    name                             = optional(string)<br/>    tags                             = optional(list(string))<br/>    enable_routing                   = optional(bool)<br/>    enable_custom_routes_propagation = optional(bool)<br/>    region                           = optional(string)<br/>    private_network = optional(list(object({<br/>      name                             = optional(string)<br/>      tags                             = optional(list(string))<br/>      region                           = optional(string)<br/>      enable_default_route_propagation = optional(bool)<br/>    })))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_autoscaling_instance_group"></a> [autoscaling\_instance\_group](#output\_autoscaling\_instance\_group) | Informations relatives aux autoscaling group. |
| <a name="output_autoscaling_instance_policy"></a> [autoscaling\_instance\_policy](#output\_autoscaling\_instance\_policy) | Informations relatives aux policies d'autoscaling group. |
| <a name="output_autoscaling_instance_template"></a> [autoscaling\_instance\_template](#output\_autoscaling\_instance\_template) | Informations relatives aux templates d'autoscaling group. |
| <a name="output_block_snapshot"></a> [block\_snapshot](#output\_block\_snapshot) | Informations relatives aux volumes de type Block. |
| <a name="output_block_volume"></a> [block\_volume](#output\_block\_volume) | Informations relatives aux volumes de type Block. |
| <a name="output_lb"></a> [lb](#output\_lb) | Informations relatives aux load balancers. |
| <a name="output_lb_backend"></a> [lb\_backend](#output\_lb\_backend) | Informations relatives aux backends des load balancers. |
| <a name="output_lb_ip"></a> [lb\_ip](#output\_lb\_ip) | Informations relatives aux ip réservées aux load balancers. |
| <a name="output_private_network"></a> [private\_network](#output\_private\_network) | Informations relatives aux réseaux privés. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Informations relatives aux VPC. |
