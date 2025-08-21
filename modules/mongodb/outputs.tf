output "instance" {
  value = {
    for a in scaleway_mongodb_instance.this : a => {
      id                = a.id
      name              = a.name
      tags              = a.tags
      user_name         = a.user_name
      password          = sensitive(a.password)
      created_at        = a.created_at
      updated_at        = a.updated_at
      settings          = a.settings
      volume_type       = a.volume_type
      volume_size_in_gb = a.volume_size_in_gb
      version           = a.version
    }
  }
}

output "snapshot" {
  value = {
    for a in scaleway_mongodb_snapshot.this : a => {
      id         = a.id
      name       = a.name
      updated_at = a.updated_at
      created_at = a.created_at
      size       = a.size
      expires_at = a.expires_at
      node_type  = a.node_type
    }
  }
}