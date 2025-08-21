# scaleway_secret
output "secrets" {
  value = {
    for secret in scaleway_secret.this : secret => {
      version_count    = secret.version_count
      status           = secret.status
      created_at       = secret.created_at
      updated_at       = secret.updated_at
      id               = secret.id
      region           = secret.region
      ephemeral_policy = secret.ephemeral_policy
    }
  }
}

# scaleway_secret_version
output "secret_versions" {
  value = {
    for secret_version in scaleway_secret_version.this : secret_version => {
      revision   = secret_version.revision
      status     = secret_version.status
      created_at = secret_version.created_at
      updated_at = secret_version.updated_at
      id         = secret_version.id
      data       = sensitive(secret_version.data)
    }
  }
}
