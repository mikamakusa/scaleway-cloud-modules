output "bucket" {
  description = "Informations relatives aux Buckets."
  value = {
    for a in scaleway_object_bucket.this : a => {
      id                  = a.id
      acl                 = a.acl
      lifecycle_rule      = a.lifecycle_rule
      tags                = a.tags
      versioning          = a.versioning
      api_endpoint        = a.api_endpoint
      object_lock_enabled = a.object_lock_enabled
      region              = a.region
      endpoint            = a.endpoint
      name                = a.name
    }
  }
}

output "object" {
  description = "Informations relatives aux objets à uploader dans le/les bucket/s."
  value = {
    for b in scaleway_object.this : b => {
      id            = b.id
      region        = b.region
      tags          = b.tags
      bucket        = b.bucket
      key           = b.key
      metadata      = b.metadata
      visibility    = b.visibility
      storage_class = b.storage_class
    }
  }
}

output "acl" {
  description = "Informations relatives aux listes de contrôle d'accès."
  value = {
    for c in scaleway_object_bucket_acl.this : c => {
      id                    = c.id
      acl                   = c.acl
      bucket                = c.bucket
      access_control_policy = c.access_control_policy
      expected_bucket_owner = c.expected_bucket_owner
    }
  }
}

output "lock_configuration" {
  description = "Informations relatives au système de locking du bucket."
  value = {
    for d in scaleway_object_bucket_lock_configuration.this : d => {
      id     = d.id
      bucket = d.bucket
      region = d.region
      rule   = d.rule
    }
  }
}