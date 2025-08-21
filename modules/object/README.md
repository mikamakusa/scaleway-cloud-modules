## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.57.0 |

## Modules

No modules.

## Usage
```hcl
terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = "2.57.0"
    }
  }
}

provider "scaleway" {}

data "scaleway_account_project" "this" {
  name = "default"
}

resource "scaleway_iam_application" "example-app" {
  name = "example-app"
}

resource "scaleway_iam_policy" "policy" {
  name           = "object-storage-policy"
  application_id = scaleway_iam_application.example-app.id
  rule {
    project_ids          = [data.scaleway_account_project.this.id]
    permission_set_names = ["ObjectStorageBucketsRead"]
  }
}

resource "scaleway_object_bucket_policy" "this" {
  bucket = module.scaleway_bucket_object.bucket[0].name
  policy = jsonencode(
    {
      Version = "2023-04-17",
      Statement = [
        {
          Sid    = "Delegate read access",
          Effect = "Allow",
          Principal = {
            SCW = "application_id:${scaleway_iam_application.example-app.id}"
          },
          Action = [
            "s3:ListBucket",
            "s3:GetObject",
          ]
          Resource = [
            "${module.scaleway_bucket_object.bucket[0].name}"
          ]
        }
      ]
    }
  )
}

module "scaleway_bucket_object" {
  source = "../../"
  bucket = [{
    name                = "bucket-with-acl"
    region              = "fr-par"
    force_destroy       = false
    versionning_enabled = true
    lifecycle_rule = [{
      enabled = true
      expiration = [{
        days = 15
      }]
      transition = [{
        storage_class = "GLACIER"
      }]
    }]
    acl = [{
      access_control_policy = [
        {
          grant = [
            {
              permission = "FULL_CONTROL"
              grantee = [
                {
                  id   = "<project-id>:<project-id>"
                  type = "CanonicalUser"
                }
              ]
            }
          ]
          owner = [
            {
              id = "<project-id>"
            }
          ]
        }
      ]
    }]
    default_retention = [
      {
        mode = "GOVERNANCE"
        days = 1
      }
    ]
  }]
}
```

## Resources

| Name | Type |
|------|------|
| [scaleway_object.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/object) | resource |
| [scaleway_object_bucket.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/object_bucket) | resource |
| [scaleway_object_bucket_acl.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/object_bucket_acl) | resource |
| [scaleway_object_bucket_lock_configuration.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/object_bucket_lock_configuration) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_bucket"></a> [bucket](#input\_bucket) | n/a | <pre>list(object({<br/>    name               = string<br/>    tags               = optional(map(any))<br/>    region             = optional(string)<br/>    force_destroy      = optional(bool)<br/>    versioning_enabled = optional(bool)<br/>    lifecycle_rule = optional(list(object({<br/>      enabled                                = bool<br/>      abort_incomplete_multipart_upload_days = optional(number)<br/>      prefix                                 = optional(string)<br/>      tags                                   = optional(map(any))<br/>      expiration = optional(list(object({<br/>        days = optional(number)<br/>      })), [])<br/>      transition = optional(list(object({<br/>        storage_class = string<br/>      })))<br/>    })))<br/>    object = optional(list(object({<br/>      key           = string<br/>      file          = optional(string)<br/>      storage_class = optional(string)<br/>      visibility    = optional(string)<br/>      metadata      = optional(map(any))<br/>      tags          = optional(map(any))<br/>    })))<br/>    acl = optional(list(object({<br/>      acl                   = optional(string)<br/>      expected_bucket_owner = optional(string)<br/>      region                = optional(string)<br/>      access_control_policy = optional(list(object({<br/>        grant = optional(list(object({<br/>          permission = string<br/>          grantee = optional(list(object({<br/>            id   = string<br/>            type = string<br/>          })), [])<br/>        })), [])<br/>        owner = optional(list(object({<br/>          id           = string<br/>          display_name = optional(string)<br/>        })), [])<br/>      })), [])<br/>    })))<br/>    default_retention = optional(list(object({<br/>      mode  = string<br/>      days  = optional(number)<br/>      years = optional(number)<br/>    })))<br/>  }))</pre> | n/a | yes |
| <a name="input_metadata"></a> [metadata](#input\_metadata) | n/a | `map(string)` | `{}` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acl"></a> [acl](#output\_acl) | Informations relatives aux listes de contrôle d'accès. |
| <a name="output_bucket"></a> [bucket](#output\_bucket) | Informations relatives aux Buckets. |
| <a name="output_lock_configuration"></a> [lock\_configuration](#output\_lock\_configuration) | Informations relatives au système de locking du bucket. |
| <a name="output_object"></a> [object](#output\_object) | Informations relatives aux objets à uploader dans le/les bucket/s. |
