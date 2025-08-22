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
| [scaleway_webhosting.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/webhosting) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_webhosting_offer.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/webhosting_offer) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_webhosting"></a> [webhosting](#input\_webhosting) | n/a | <pre>list(object({<br/>    domain     = string<br/>    email      = string<br/>    option_ids = optional(list(string))<br/>    tags       = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_webhosting_offer"></a> [webhosting\_offer](#input\_webhosting\_offer) | n/a | <pre>object({<br/>    name          = optional(string)<br/>    control_panel = optional(string)<br/>    offer_id      = optional(string)<br/>  })</pre> | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_hosting"></a> [hosting](#output\_hosting) | n/a |
