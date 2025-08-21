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
variable "user_name" {
  type      = string
  sensitive = true
}

variable "password" {
  type      = string
  sensitive = true
}

module "redis" {
  source       = "./"
  project_name = "my-project-redis"
  vpc = {
    name = "vpc-1"
  }
  private_network = {
    name = "vpc-pn-1"
  }
  clusters = {
    red-1 = {
      version   = "6.2.7"
      node_type = "RED1-MICRO"
      user_name = var.user_name
      password  = var.password
      settings = {
        "maxclients"    = "1000"
        "tcp-keepalive" = "120"
      }
    }
  }
}
```

## Resources

| Name | Type |
|------|------|
| [scaleway_redis_cluster.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/redis_cluster) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc) | data source |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc_private_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acls"></a> [acls](#input\_acls) | n/a | <pre>list(object({<br/>    ip          = string<br/>    description = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_clusters"></a> [clusters](#input\_clusters) | n/a | <pre>map(object({<br/>    node_type    = string<br/>    password     = string<br/>    user_name    = string<br/>    version      = string<br/>    tags         = optional(list(string))<br/>    zone         = optional(string)<br/>    cluster_size = optional(number)<br/>    tls_enabled  = optional(bool)<br/>    settings     = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>object({<br/>    name = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>object({<br/>    name            = optional(string)<br/>    is_default      = optional(bool)<br/>    organization_id = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_clusters"></a> [clusters](#output\_clusters) | n/a |
