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

- [apple_silicon_server](example/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_apple_silicon_server.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/apple_silicon_server) | resource |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc) | resource |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/vpc_private_network) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_apple_silicon_servers"></a> [apple\_silicon\_servers](#input\_apple\_silicon\_servers) | n/a | <pre>list(object({<br/>    type             = string<br/>    name             = optional(string)<br/>    zone             = optional(string)<br/>    enable_vpc       = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_ipv4_subnet"></a> [ipv4\_subnet](#input\_ipv4\_subnet) | n/a | `string` | `null` | no |
| <a name="input_ipv6_subnets"></a> [ipv6\_subnets](#input\_ipv6\_subnets) | n/a | `string` | `null` | no |
| <a name="input_vpcs"></a> [vpcs](#input\_vpcs) | n/a | <pre>list(object({<br/>    name                             = optional(string)<br/>    tags                             = optional(list(string))<br/>    enable_routing                   = optional(bool)<br/>    enable_custom_routes_propagation = optional(bool)<br/>    region                           = optional(string)<br/>    private_network = optional(list(object({<br/>      name                             = optional(string)<br/>      tags                             = optional(list(string))<br/>      region                           = optional(string)<br/>      enable_default_route_propagation = optional(bool)<br/>    })))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_apple_silicon_server"></a> [apple\_silicon\_server](#output\_apple\_silicon\_server) | Informations relatives aux serveurs Apple Silicon!, |
| <a name="output_private_network"></a> [private\_network](#output\_private\_network) | Informations relatives aux réseaux privés. |
| <a name="output_vpc"></a> [vpc](#output\_vpc) | Informations relatives aux VPC. |
