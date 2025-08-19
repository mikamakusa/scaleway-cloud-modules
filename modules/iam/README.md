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

## Usages

- [api_key](examples/api_key/main.tf)
- [application](examples/application/main.tf)
- [group](examples/group/main.tf)
- [policy](examples/policy/main.tf)
- [ssh_key](examples/ssh_key/main.tf)
- [user](examples/user/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_iam_api_key.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_api_key) | resource |
| [scaleway_iam_application.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_application) | resource |
| [scaleway_iam_group.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_group) | resource |
| [scaleway_iam_group_membership.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_group_membership) | resource |
| [scaleway_iam_policy.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_policy) | resource |
| [scaleway_iam_ssh_key.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_ssh_key) | resource |
| [scaleway_iam_user.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iam_user) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_api_key"></a> [api\_key](#input\_api\_key) | n/a | <pre>list(object({<br/>    id                 = string<br/>    description        = optional(string)<br/>    application_id     = optional(string)<br/>    user_id            = optional(string)<br/>    expires_at         = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_application"></a> [application](#input\_application) | n/a | <pre>list(object({<br/>    id              = string<br/>    name            = optional(string)<br/>    description     = optional(string)<br/>    tags            = optional(list(string))<br/>    organization_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_group"></a> [group](#input\_group) | n/a | <pre>list(object({<br/>    id                  = string<br/>    name                = string<br/>    description         = optional(string)<br/>    tags                = optional(list(string))<br/>    application_ids     = optional(string)<br/>    user_ids            = optional(string)<br/>    external_membership = optional(bool)<br/>    organization_id     = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_group_membership"></a> [group\_membership](#input\_group\_membership) | n/a | <pre>list(object({<br/>    id             = string<br/>    group_id       = string<br/>    user_id        = optional(string)<br/>    application_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_policy"></a> [policy](#input\_policy) | n/a | <pre>list(object({<br/>    id             = string<br/>    name           = optional(string)<br/>    description    = optional(string)<br/>    tags           = optional(list(string))<br/>    no_principal   = optional(bool)<br/>    application_id = optional(string)<br/>    rule = optional(object({<br/>      permission_set_names = optional(list(string))<br/>      project_ids          = optional(list(string))<br/>      organization_id      = optional(string)<br/>      condition            = optional(string)<br/>    }))<br/>  }))</pre> | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_ssh_key"></a> [ssh\_key](#input\_ssh\_key) | n/a | <pre>list(object({<br/>    id         = string<br/>    public_key = string<br/>    name       = optional(string)<br/>    disabled   = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_user"></a> [user](#input\_user) | n/a | <pre>list(object({<br/>    id                  = string<br/>    email               = string<br/>    tags                = optional(list(string))<br/>    username            = optional(string)<br/>    password            = optional(string)<br/>    phone_number        = optional(string)<br/>    send_password_email = optional(bool)<br/>    send_welcome_email  = optional(bool)<br/>    first_name          = optional(string)<br/>    last_name           = optional(string)<br/>    locale              = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_api_key"></a> [api\_key](#output\_api\_key) | n/a |
| <a name="output_application"></a> [application](#output\_application) | n/a |
| <a name="output_group"></a> [group](#output\_group) | n/a |
| <a name="output_group_membership"></a> [group\_membership](#output\_group\_membership) | n/a |
| <a name="output_policy"></a> [policy](#output\_policy) | n/a |
| <a name="output_ssh_key"></a> [ssh\_key](#output\_ssh\_key) | n/a |
| <a name="output_user"></a> [user](#output\_user) | n/a |
