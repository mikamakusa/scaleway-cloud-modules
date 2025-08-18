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

- [namespace-regitry](examples/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_registry_namespace.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/registry_namespace) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_registry_namespace"></a> [registry\_namespace](#input\_registry\_namespace) | n/a | <pre>map(object({<br/>    description = optional(string)<br/>    is_public   = optional(bool)<br/>    region      = optional(string)<br/>  }))</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_registry_namespace"></a> [registry\_namespace](#output\_registry\_namespace) | Informations relatives au namespace du registry des conteneurs. |
