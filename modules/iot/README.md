## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.59.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_databases"></a> [databases](#module\_databases) | ../databases | n/a |

## Resources

| Name | Type |
|------|------|
| [scaleway_iot_device.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iot_device) | resource |
| [scaleway_iot_hub.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iot_hub) | resource |
| [scaleway_iot_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iot_network) | resource |
| [scaleway_iot_route.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/iot_route) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_object_bucket.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/object_bucket) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hubs"></a> [hubs](#input\_hubs) | n/a | <pre>list(object({<br/>    name         = string<br/>    product_plan = string<br/>    region       = optional(string)<br/>    devices = optional(list(object({<br/>      name                       = string<br/>      description                = optional(string)<br/>      allow_insecure             = optional(bool)<br/>      allow_multiple_connections = optional(bool)<br/>    })))<br/>    networks = optional(list(object({<br/>      name         = string<br/>      type         = string<br/>      topic_prefix = optional(string)<br/>    })))<br/>    routes = optional(list(object({<br/>      name             = string<br/>      topic            = string<br/>      database_name    = optional(string)<br/>      database_query   = optional(string)<br/>      s3_strategy      = optional(string)<br/>      s3_object_prefix = optional(string)<br/>    })))<br/>  }))</pre> | n/a | yes |
| <a name="input_instance"></a> [instance](#input\_instance) | n/a | `any` | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_rest"></a> [rest](#input\_rest) | n/a | <pre>object({<br/>    headers = map(string)<br/>    uri     = string<br/>    verb    = string<br/>  })</pre> | `null` | no |
| <a name="input_s3_bucket_name"></a> [s3\_bucket\_name](#input\_s3\_bucket\_name) | n/a | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_devices"></a> [devices](#output\_devices) | n/a |
| <a name="output_hubs"></a> [hubs](#output\_hubs) | n/a |
| <a name="output_networks"></a> [networks](#output\_networks) | n/a |
| <a name="output_routes"></a> [routes](#output\_routes) | n/a |
