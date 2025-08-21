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

## Examples
```hcl
module "instance" {
  source = "../.."
  project_name = "scl-project-mongo"
  vpc = {
    name = "vpc-1"
  }
  private_network = {
    name = "vpc-pn-1"
  }
  instance = [
    {
      name              = "test-mongodb-basic1"
      version           = "7.0.12"
      node_type         = "MGDB-PLAY2-NANO"
      node_number       = 1
      user_name         = "my_initial_user"
      password          = "thiZ_is_v&ry_s3cret"
      volume_size_in_gb = 5
    }
  ]
}
```

## Resources

| Name | Type |
|------|------|
| [scaleway_mongodb_instance.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/mongodb_instance) | resource |
| [scaleway_mongodb_snapshot.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/mongodb_snapshot) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc) | data source |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc_private_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | n/a | <pre>list(object({<br/>    node_number        = number<br/>    node_type          = string<br/>    name               = string<br/>    version            = optional(string)<br/>    user_name          = optional(string)<br/>    password           = optional(string)<br/>    tags               = optional(list(string))<br/>    volume_type        = optional(string)<br/>    volume_size_in_gb  = optional(number)<br/>    snapshot = optional(list(object({<br/>      expires_at = string<br/>      name       = optional(string)<br/>      region     = optional(string)<br/>    })))<br/>  }))</pre> | n/a | yes |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>object({<br/>    name = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>object({<br/>    name            = optional(string)<br/>    is_default      = optional(bool)<br/>    organization_id = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_instance"></a> [instance](#output\_instance) | n/a |
| <a name="output_snapshot"></a> [snapshot](#output\_snapshot) | n/a |
