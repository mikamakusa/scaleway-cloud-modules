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

- [block](example/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_block_snapshot.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/block_snapshot) | resource |
| [scaleway_block_volume.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/block_volume) | resource |
| [scaleway_object.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/object) | resource |
| [scaleway_object_bucket.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/object_bucket) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_block_volumes"></a> [block\_volumes](#input\_block\_volumes) | n/a | <pre>list(object({<br/>    iops       = number<br/>    size_in_gb = number<br/>    name       = optional(string)<br/>    tags       = optional(list(string))<br/>    zone       = optional(string)<br/>    snapshots = optional(list(object({<br/>      name = string<br/>      zone = optional(string)<br/>      tags = optional(list(string))<br/>      import = optional(list(object({<br/>        bucket_name = string<br/>        folder      = string<br/>        file        = string<br/>      })))<br/>      export = optional(list(object({<br/>        bucket_name = string<br/>        folder      = string<br/>        file        = string<br/>      })))<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_buckets"></a> [buckets](#input\_buckets) | n/a | <pre>list(object({<br/>    name          = string<br/>    tags          = optional(map(string))<br/>    region        = optional(string)<br/>    force_destroy = optional(bool)<br/>    versioning    = optional(bool)<br/>    objects = optional(list(object({<br/>      key              = string<br/>      file             = optional(string)<br/>      content          = optional(string)<br/>      content_base64   = optional(string)<br/>      storage_class    = optional(string)<br/>      visibility       = optional(string)<br/>      metadata         = optional(map(string))<br/>      tags             = optional(map(string))<br/>      sse_customer_key = optional(string)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_cors_rule"></a> [cors\_rule](#input\_cors\_rule) | n/a | <pre>list(object({<br/>    allowed_methods = list(string)<br/>    allowed_origins = list(string)<br/>    allowed_headers = optional(list(string))<br/>    expose_headers  = optional(list(string))<br/>    max_age_seconds = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_lifecycle_rule"></a> [lifecycle\_rule](#input\_lifecycle\_rule) | n/a | <pre>list(object({<br/>    enabled                                = bool<br/>    abort_incomplete_multipart_upload_days = optional(number)<br/>    id                                     = optional(string)<br/>    tags                                   = optional(map(string))<br/>    storage_class                          = string<br/>    transition_days                        = optional(string)<br/>    expiration_days                        = number<br/>  }))</pre> | `[]` | no |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | n/a | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_block_snapshot"></a> [block\_snapshot](#output\_block\_snapshot) | Informations relatives aux snapshots des volumes de stockage par blocs. |
| <a name="output_block_volume"></a> [block\_volume](#output\_block\_volume) | Informations relatives aux volumes de stockage par blocs. |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Informations relatives aux Buckets. |
| <a name="output_object"></a> [object](#output\_object) | Informations relatives aux objets à uploader dans le/les bucket/s. |
