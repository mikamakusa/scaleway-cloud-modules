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

output "block_volume" {
  description = "Informations relatives aux volumes de stockage par blocs."
  value = {
    for a in scaleway_block_volume.this : a => {
      id         = a.id
      name       = a.name
      size_in_gb = a.size_in_gb
      iops       = a.iops
    }
  }
}

output "block_snapshot" {
  description = "Informations relatives aux snapshots des volumes de stockage par blocs."
  value = {
    for a in scaleway_block_snapshot.this : a => {
      id   = a.id
      name = a.name
    }
  }
}