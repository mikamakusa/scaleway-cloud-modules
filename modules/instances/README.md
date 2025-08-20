## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.59.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [scaleway_instance_image.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_image) | resource |
| [scaleway_instance_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_ip) | resource |
| [scaleway_instance_ip_reverse_dns.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_ip_reverse_dns) | resource |
| [scaleway_instance_placement_group.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_placement_group) | resource |
| [scaleway_instance_private_nic.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_private_nic) | resource |
| [scaleway_instance_security_group.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_security_group) | resource |
| [scaleway_instance_security_group_rules.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_security_group_rules) | resource |
| [scaleway_instance_server.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_server) | resource |
| [scaleway_instance_snapshot.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_snapshot) | resource |
| [scaleway_instance_user_data.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_user_data) | resource |
| [scaleway_instance_volume.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/instance_volume) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc) | data source |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc_private_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_images"></a> [images](#input\_images) | n/a | <pre>list(object({<br/>    id                    = string<br/>    root_volume_id        = optional(string)<br/>    additional_volume_ids = optional(string)<br/>    architecture          = optional(string)<br/>    name                  = optional(string)<br/>    public                = optional(bool)<br/>    tags                  = optional(list(string))<br/>    zone                  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_inbound_rule"></a> [inbound\_rule](#input\_inbound\_rule) | n/a | <pre>list(object({<br/>    action     = optional(string)<br/>    port       = optional(number)<br/>    port_range = optional(string)<br/>    protocol   = optional(string)<br/>    ip_range   = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_ips"></a> [ips](#input\_ips) | n/a | <pre>list(object({<br/>    type       = optional(string)<br/>    zone       = optional(string)<br/>    is_reverse = bool<br/>    reverse    = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_outbound_rule"></a> [outbound\_rule](#input\_outbound\_rule) | n/a | <pre>list(object({<br/>    action     = optional(string)<br/>    port       = optional(number)<br/>    port_range = optional(string)<br/>    protocol   = optional(string)<br/>    ip_range   = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_placement_groups"></a> [placement\_groups](#input\_placement\_groups) | n/a | <pre>list(object({<br/>    id          = string<br/>    name        = string<br/>    policy_mode = optional(string)<br/>    policy_type = optional(string)<br/>    zone        = optional(string)<br/>    tags        = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>object({<br/>    name = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_private_nics"></a> [private\_nics](#input\_private\_nics) | n/a | <pre>list(object({<br/>    server_id = string<br/>    tags      = optional(list(string))<br/>    zone      = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_rules"></a> [rules](#input\_rules) | n/a | <pre>list(object({<br/>    id                = string<br/>    security_group_id = string<br/>  }))</pre> | `[]` | no |
| <a name="input_security_groups"></a> [security\_groups](#input\_security\_groups) | n/a | <pre>list(object({<br/>    id                      = string<br/>    name                    = optional(string)<br/>    description             = optional(string)<br/>    inbound_default_policy  = optional(string)<br/>    outbound_default_policy = optional(string)<br/>    zone                    = optional(string)<br/>    enable_default_security = optional(bool)<br/>    stateful                = optional(bool)<br/>    external_rules          = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_servers"></a> [servers](#input\_servers) | n/a | <pre>list(object({<br/>    id                     = string<br/>    type                   = string<br/>    image                  = optional(string)<br/>    name                   = optional(string)<br/>    tags                   = optional(list(string))<br/>    security_group_id      = optional(string)<br/>    placement_group_id     = optional(string)<br/>    additional_volume_ids  = optional(string)<br/>    enable_dynamic_ip      = optional(bool)<br/>    ip_id                  = optional(string)<br/>    ip_ids                 = optional(list(string))<br/>    state                  = optional(string)<br/>    boot_type              = optional(string)<br/>    replace_on_type_change = optional(bool)<br/>    protected              = optional(bool)<br/>    zone                   = optional(string)<br/>    root_volume = optional(list(object({<br/>      volume_id   = optional(string)<br/>      volume_type = optional(string)<br/>      sbs_iops    = optional(number)<br/>      size_in_gb  = optional(number)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_snapshots"></a> [snapshots](#input\_snapshots) | n/a | <pre>list(object({<br/>    id        = string<br/>    volume_id = optional(string)<br/>    type      = optional(string)<br/>    name      = optional(string)<br/>    zone      = optional(string)<br/>    tags      = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | n/a | <pre>list(object({<br/>    id        = string<br/>    key       = string<br/>    server_id = string<br/>    value     = string<br/>  }))</pre> | `[]` | no |
| <a name="input_volumes"></a> [volumes](#input\_volumes) | n/a | <pre>list(object({<br/>    type        = string<br/>    size_in_gb  = optional(number)<br/>    snapshot_id = optional(string)<br/>    name        = optional(string)<br/>    zone        = optional(string)<br/>    tags        = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>object({<br/>    name            = optional(string)<br/>    is_default      = optional(bool)<br/>    organization_id = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_images"></a> [images](#output\_images) | n/a |
| <a name="output_ip_reverse_dns"></a> [ip\_reverse\_dns](#output\_ip\_reverse\_dns) | n/a |
| <a name="output_ips"></a> [ips](#output\_ips) | n/a |
| <a name="output_placement_groups"></a> [placement\_groups](#output\_placement\_groups) | n/a |
| <a name="output_private_nics"></a> [private\_nics](#output\_private\_nics) | n/a |
| <a name="output_security_group_ruless"></a> [security\_group\_ruless](#output\_security\_group\_ruless) | n/a |
| <a name="output_security_groups"></a> [security\_groups](#output\_security\_groups) | n/a |
| <a name="output_servers"></a> [servers](#output\_servers) | n/a |
| <a name="output_snapshots"></a> [snapshots](#output\_snapshots) | n/a |
| <a name="output_user_datas"></a> [user\_datas](#output\_user\_datas) | n/a |
| <a name="output_volumes"></a> [volumes](#output\_volumes) | n/a |
