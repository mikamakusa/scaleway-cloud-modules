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

## Examples
```hcl
module "ipam" {
  source       = "."
  project_name = "xxxxxx"
  vpc = {
    name = "foobar"
  }
  private_network = {
    name = "foobar"
  }
  ips = [{
    id      = "5"
    address = "172.16.32.7"
    reverse_dns = [{
      hostname = "example.com"
      address  = "42"
    }]
  }]
}
```

## Resources

| Name | Type |
|------|------|
| [scaleway_ipam_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/ipam_ip) | resource |
| [scaleway_ipam_ip_reverse_dns.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/ipam_ip_reverse_dns) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_ipam_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/ipam_ip) | data source |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc) | data source |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc_private_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ips"></a> [ips](#input\_ips) | n/a | <pre>list(object({<br/>    id      = string<br/>    address = optional(string)<br/>    tags    = optional(list(string))<br/>    is_ipv6 = optional(bool)<br/>    region  = optional(string)<br/>    reverse_dns = optional(list(object({<br/>      address  = string<br/>      hostname = string<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>object({<br/>    name = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>object({<br/>    name            = optional(string)<br/>    is_default      = optional(bool)<br/>    organization_id = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ip_reverse_dns"></a> [ip\_reverse\_dns](#output\_ip\_reverse\_dns) | scaleway\_ipam\_ip\_reverse\_dns |
| <a name="output_ips"></a> [ips](#output\_ips) | scaleway\_ipam\_ip |
