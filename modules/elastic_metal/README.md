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

- [metal](examples/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_baremetal_server.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/baremetal_server) | resource |
| [scaleway_flexible_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/flexible_ip) | resource |
| [scaleway_flexible_ip_mac_address.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/flexible_ip_mac_address) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_baremetal_offer.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/baremetal_offer) | data source |
| [scaleway_baremetal_option.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/baremetal_option) | data source |
| [scaleway_baremetal_os.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/baremetal_os) | data source |
| [scaleway_iam_ssh_key.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/iam_ssh_key) | data source |
| [scaleway_ipam_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/ipam_ip) | data source |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc) | data source |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc_private_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_flexible_ips"></a> [flexible\_ips](#input\_flexible\_ips) | n/a | <pre>list(object({<br/>    description = optional(string)<br/>    tags        = optional(list(string))<br/>    reverse     = optional(string)<br/>    is_ipv6     = optional(bool)<br/>    zone        = optional(string)<br/>    server_id   = optional(string)<br/>    mac_addresses = optional(list(object({<br/>      type = optional(string)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_offer"></a> [offer](#input\_offer) | n/a | <pre>object({<br/>    name                = optional(string)<br/>    subscription_period = optional(string)<br/>    offer_id            = optional(string)<br/>    zone                = optional(string)<br/>    include_disabled    = optional(bool)<br/>  })</pre> | `null` | no |
| <a name="input_option"></a> [option](#input\_option) | n/a | <pre>list(object({<br/>    id        = string<br/>    name      = optional(string)<br/>    option_id = optional(string)<br/>    zone      = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_os"></a> [os](#input\_os) | n/a | <pre>object({<br/>    zone    = optional(string)<br/>    name    = optional(string)<br/>    version = optional(string)<br/>    os_id   = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>object({<br/>    name = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | # DATAS | `string` | n/a | yes |
| <a name="input_servers"></a> [servers](#input\_servers) | # RESOURCES | <pre>list(object({<br/>    offer                       = string<br/>    os                          = optional(string)<br/>    ssh_key_ids                 = optional(string)<br/>    user                        = optional(string)<br/>    password                    = optional(string)<br/>    service_password            = optional(string)<br/>    service_user                = optional(string)<br/>    reinstall_on_config_changes = optional(bool)<br/>    install_config_afterward    = optional(bool)<br/>    name                        = optional(string)<br/>    hostname                    = optional(string)<br/>    description                 = optional(string)<br/>    tags                        = optional(list(string))<br/>    zone                        = optional(string)<br/>    partitioning                = optional(string)<br/>    protected                   = optional(bool)<br/>    id                          = optional(string)<br/>    options = optional(list(object({<br/>      option_id  = string<br/>      expirez_at = optional(string)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | n/a | <pre>object({<br/>    name       = optional(string)<br/>    ssh_key_id = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>object({<br/>    name            = optional(string)<br/>    is_default      = optional(bool)<br/>    organization_id = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_mac_addresses"></a> [ip\_mac\_addresses](#output\_ip\_mac\_addresses) | n/a |
| <a name="output_ips"></a> [ips](#output\_ips) | n/a |
| <a name="output_servers"></a> [servers](#output\_servers) | n/a |
