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

- [container with namespace, cron and token](examples/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_container.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/container) | resource |
| [scaleway_container_cron.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/container_cron) | resource |
| [scaleway_container_domain.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/container_domain) | resource |
| [scaleway_container_namespace.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/container_namespace) | resource |
| [scaleway_container_token.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/container_token) | resource |
| [scaleway_container_trigger.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/container_trigger) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_health_check"></a> [health\_check](#input\_health\_check) | n/a | <pre>list(object({<br/>    failure_threshold = number<br/>    interval          = string<br/>    http_path         = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_namespaces"></a> [namespaces](#input\_namespaces) | n/a | <pre>list(object({<br/>    name                         = string<br/>    description                  = optional(string)<br/>    tags                         = optional(list(string))<br/>    region                       = optional(string)<br/>    environment_variables        = optional(map(string))<br/>    secret_environment_variables = optional(map(string))<br/>    activate_vpc_integration     = optional(bool)<br/>    containers = optional(list(object({<br/>      name                = string<br/>      description         = optional(string)<br/>      min_scale           = optional(number)<br/>      max_scale           = optional(number)<br/>      memory_limit        = optional(number)<br/>      cpu_limit           = optional(number)<br/>      timeout             = optional(number)<br/>      privacy             = optional(string)<br/>      registry_image      = optional(string)<br/>      registry_sha256     = optional(string)<br/>      protocol            = optional(string)<br/>      http_option         = optional(string)<br/>      sandbox             = optional(string)<br/>      port                = optional(number)<br/>      deploy              = optional(bool)<br/>      local_storage_limit = optional(number)<br/>      command             = optional(list(string))<br/>      args                = optional(list(string))<br/>      cron = optional(list(object({<br/>        args     = string<br/>        schedule = string<br/>        name     = optional(string)<br/>      })))<br/>      domain = optional(list(object({<br/>        hostname = string<br/>      })))<br/>      trigger = optional(list(object({<br/>        name        = optional(string)<br/>        description = optional(string)<br/>        region      = optional(string)<br/>      })))<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_scaling_option"></a> [scaling\_option](#input\_scaling\_option) | n/a | <pre>list(object({<br/>    concurrent_requests_threshold = optional(number)<br/>    cpu_usage_threshold           = optional(number)<br/>    memory_usage_threshold        = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_tokens"></a> [tokens](#input\_tokens) | n/a | <pre>list(object({<br/>    container_name = string<br/>    namespace_name = string<br/>    description    = optional(string)<br/>    expires_at     = optional(string)<br/>    region         = optional(string)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_container"></a> [container](#output\_container) | n/a |
| <a name="output_namespace"></a> [namespace](#output\_namespace) | n/a |
