resource "scaleway_secret" "this" {
  for_each    = var.secrets
  name        = each.key
  path        = each.value.path
  protected   = each.value.protected
  description = each.value.description
  tags        = concat(var.tags, each.value.tags)
  type        = each.value.type
  region      = each.value.region
  project_id  = data.scaleway_account_project.this.id

  dynamic "ephemeral_policy" {
    for_each = var.ephemeral_policy != null ? [""] : []
    content {
      action                = var.ephemeral_policy.action
      expires_once_accessed = var.ephemeral_policy.expires_once_accessed
      ttl                   = var.ephemeral_policy.ttl
    }
  }
}

resource "scaleway_secret_version" "this" {
  for_each    = { for secret in keys(var.secrets) : secret => var.secrets[secret] if lookup(var.secrets[secret], "data") != null }
  data        = lookup(each.value, "data")
  secret_id   = scaleway_secret.this[each.key].id
  description = join(" - ", [lookup(each.value, "description"), "secret version"])
  region      = lookup(each.value, "region")
}