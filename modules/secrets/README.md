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

## Example
```hcl
module "secret" {
  source       = "./"
  project_name = "my-project-secret"
  secrets = {
    name        = "foo"
    description = "barr"
    tags        = ["foo", "terraform"]
    data        = "my_new_secret"
  }
  ephemeral_policy = {
    ttl                   = "24h"
    expires_once_accessed = true
    action                = "disable"
  }
}
```

## Resources

| Name | Type |
|------|------|
| [scaleway_secret.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/secret) | resource |
| [scaleway_secret_version.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/secret_version) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ephemeral_policy"></a> [ephemeral\_policy](#input\_ephemeral\_policy) | n/a | <pre>object({<br/>    action                = string<br/>    expires_once_accessed = optional(bool)<br/>    ttl                   = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_secrets"></a> [secrets](#input\_secrets) | n/a | <pre>map(object({<br/>    path        = optional(string)<br/>    protected   = optional(bool)<br/>    description = optional(string)<br/>    tags        = optional(list(string))<br/>    type        = optional(string)<br/>    region      = optional(string)<br/>    data        = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_secret_versions"></a> [secret\_versions](#output\_secret\_versions) | scaleway\_secret\_version |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | scaleway\_secret |
