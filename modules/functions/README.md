## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | >= 2.57.0 |

## Modules

No modules.

## Usages

- [basic](examples/basic/main.tf)
- [cron](examples/cron/main.tf)
- [token](examples/token/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_function.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/function) | resource |
| [scaleway_function_cron.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/function_cron) | resource |
| [scaleway_function_domain.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/function_domain) | resource |
| [scaleway_function_namespace.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/function_namespace) | resource |
| [scaleway_function_token.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/function_token) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_function"></a> [function](#input\_function) | n/a | <pre>list(object({<br/>    handler                      = string<br/>    privacy                      = string<br/>    runtime                      = string<br/>    name                         = string<br/>    namespace_name               = optional(string)<br/>    description                  = optional(string)<br/>    region                       = optional(string)<br/>    environment_variables        = optional(map(string))<br/>    secret_environment_variables = optional(map(string))<br/>    min_scale                    = optional(number)<br/>    max_scale                    = optional(number)<br/>    memory_limit                 = optional(number)<br/>    zip_file                     = optional(string)<br/>    deploy                       = optional(bool)<br/>    http_option                  = optional(string)<br/>    sandbox                      = optional(string)<br/>    tags                         = optional(list(string))<br/>    activate_vpc_integration     = optional(bool)<br/>    args                         = optional(string)<br/>    schedule                     = optional(string)<br/>    hostname                     = optional(string)<br/>    expires_at                   = optional(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cron"></a> [cron](#output\_cron) | n/a |
| <a name="output_domain"></a> [domain](#output\_domain) | n/a |
| <a name="output_functions"></a> [functions](#output\_functions) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
| <a name="output_token"></a> [token](#output\_token) | n/a |
