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