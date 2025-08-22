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
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc) | resource |
| [scaleway_vpc_acl.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_acl) | resource |
| [scaleway_vpc_gateway_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_gateway_network) | resource |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_private_network) | resource |
| [scaleway_vpc_public_gateway.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway) | resource |
| [scaleway_vpc_public_gateway_dhcp.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_dhcp) | resource |
| [scaleway_vpc_public_gateway_dhcp_reservation.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_dhcp_reservation) | resource |
| [scaleway_vpc_public_gateway_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_ip) | resource |
| [scaleway_vpc_public_gateway_ip_reverse_dns.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_ip_reverse_dns) | resource |
| [scaleway_vpc_public_gateway_pat_rule.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_public_gateway_pat_rule) | resource |
| [scaleway_vpc_route.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_route) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl"></a> [acl](#input\_acl) | n/a | <pre>list(object({<br/>    id             = string<br/>    default_policy = string<br/>    vpc_id         = string<br/>    is_ipv6        = optional(string)<br/>    rules = optional(object({<br/>      action        = optional(string)<br/>      description   = optional(string)<br/>      destination   = optional(string)<br/>      dst_port_high = optional(number)<br/>      dst_port_low  = optional(number)<br/>      protocol      = optional(string)<br/>      source        = optional(string)<br/>      src_port_high = optional(number)<br/>      src_port_low  = optional(number)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_gateway_network"></a> [gateway\_network](#input\_gateway\_network) | n/a | <pre>list(object({<br/>    id                 = string<br/>    gateway_id         = string<br/>    private_network_id = string<br/>    enable_masquerade  = optional(bool)<br/>    zone               = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>list(object({<br/>    id                               = string<br/>    name                             = optional(string)<br/>    tags                             = optional(list(string))<br/>    vpc_id                           = optional(string)<br/>    enable_default_route_propagation = optional(bool)<br/>    ipv4_subnet                      = optional(string)<br/>    ipv6_subnets = optional(list(object({<br/>      subnet = string<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_public_gateway"></a> [public\_gateway](#input\_public\_gateway) | n/a | <pre>list(object({<br/>    type              = optional(string)<br/>    name              = string<br/>    tags              = optional(string)<br/>    zone              = optional(string)<br/>    ip_id             = optional(string)<br/>    bastion_enabled   = optional(bool)<br/>    bastion_port      = optional(string)<br/>    allowed_ip_ranges = optional(string)<br/>    enable_smtp       = optional(bool)<br/>    refresh_ssh_keys  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_public_gateway_dhcp"></a> [public\_gateway\_dhcp](#input\_public\_gateway\_dhcp) | n/a | <pre>list(object({<br/>    subnet               = string<br/>    address              = optional(string)<br/>    dns_local_name       = optional(string)<br/>    dns_search           = optional(list(string))<br/>    dns_servers_override = optional(list(string))<br/>    enable_dynamic       = optional(number)<br/>    pool_high            = optional(string)<br/>    pool_low             = optional(string)<br/>    rebind_timer         = optional(number)<br/>    renew_timer          = optional(number)<br/>    valid_lifetime       = optional(number)<br/>    zone                 = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_public_gateway_dhcp_reservation"></a> [public\_gateway\_dhcp\_reservation](#input\_public\_gateway\_dhcp\_reservation) | n/a | <pre>list(object({<br/>    id                 = string<br/>    gateway_network_id = string<br/>    ip_address         = string<br/>    mac_address        = string<br/>    zone               = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_public_gateway_ip"></a> [public\_gateway\_ip](#input\_public\_gateway\_ip) | n/a | <pre>list(object({<br/>    id      = string<br/>    reverse = optional(string)<br/>    tags    = optional(list(string))<br/>    zone    = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_public_gateway_ip_reverse_dns"></a> [public\_gateway\_ip\_reverse\_dns](#input\_public\_gateway\_ip\_reverse\_dns) | n/a | <pre>list(object({<br/>    id            = string<br/>    gateway_ip_id = string<br/>    reverse       = string<br/>    zone          = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_public_gateway_pat_rule"></a> [public\_gateway\_pat\_rule](#input\_public\_gateway\_pat\_rule) | n/a | <pre>list(object({<br/>    id           = string<br/>    gateway_id   = string<br/>    private_ip   = string<br/>    private_port = number<br/>    public_port  = number<br/>    zone         = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `null` | no |
| <a name="input_route"></a> [route](#input\_route) | n/a | <pre>list(object({<br/>    id                         = string<br/>    vpc_id                     = string<br/>    description                = optional(string)<br/>    tags                       = optional(string)<br/>    destination                = optional(string)<br/>    nexthop_resource_id        = optional(string)<br/>    nexthop_private_network_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>list(object({<br/>    id                               = string<br/>    name                             = optional(string)<br/>    tags                             = optional(list(string))<br/>    enable_routing                   = optional(bool)<br/>    enable_custom_routes_propagation = optional(bool)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acl"></a> [acl](#output\_acl) | scaleway\_vpc\_acl |
| <a name="output_gateway_network"></a> [gateway\_network](#output\_gateway\_network) | scaleway\_vpc\_gateway\_network |
| <a name="output_private_network"></a> [private\_network](#output\_private\_network) | scaleway\_vpc\_private\_network |
| <a name="output_public_gateway"></a> [public\_gateway](#output\_public\_gateway) | scaleway\_vpc\_public\_gateway |
| <a name="output_public_gateway_dhcp"></a> [public\_gateway\_dhcp](#output\_public\_gateway\_dhcp) | scaleway\_vpc\_public\_gateway\_dhcp |
| <a name="output_public_gateway_dhcp_reservation"></a> [public\_gateway\_dhcp\_reservation](#output\_public\_gateway\_dhcp\_reservation) | scaleway\_vpc\_public\_gateway\_dhcp\_reservation |
| <a name="output_public_gateway_ip"></a> [public\_gateway\_ip](#output\_public\_gateway\_ip) | scaleway\_vpc\_public\_gateway\_ip |
| <a name="output_public_gateway_ip_reverse_dns"></a> [public\_gateway\_ip\_reverse\_dns](#output\_public\_gateway\_ip\_reverse\_dns) | scaleway\_vpc\_public\_gateway\_ip\_reverse\_dns |
| <a name="output_public_gateway_pat_rule"></a> [public\_gateway\_pat\_rule](#output\_public\_gateway\_pat\_rule) | scaleway\_vpc\_public\_gateway\_pat\_rule |
| <a name="output_route"></a> [route](#output\_route) | scaleway\_vpc\_route |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | scaleway\_vpc |
