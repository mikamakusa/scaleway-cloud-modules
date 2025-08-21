resource "scaleway_object_bucket" "this" {
  for_each      = { for a in var.bucket : a.name => a }
  name          = join("-", [each.value.name, "bucket"])
  tags          = merge(var.tags, each.value.tags)
  region        = each.value.region
  force_destroy = each.value.force_destroy
  project_id    = data.scaleway_account_project.this.project_id

  dynamic "lifecycle_rule" {
    for_each = lookup(each.value, "lifecycle_rule")
    content {
      enabled                                = lookup(lifecycle_rule.value, "enabled")
      abort_incomplete_multipart_upload_days = lookup(lifecycle_rule.value, "abort_incomplete_multipart_upload_days")
      prefix                                 = lookup(lifecycle_rule.value, "prefix")
      tags                                   = merge(var.tags, lookup(lifecycle_rule.value, "tags"))

      dynamic "expiration" {
        for_each = lookup(lifecycle_rule.value, "expiration")
        content {
          days = lookup(expiration.value, "days")
        }
      }
      dynamic "transition" {
        for_each = lookup(lifecycle_rule.value, "transition")
        content {
          storage_class = lookup(transition.value, "storage_class")
        }
      }
    }
  }

  versioning {
    enabled = each.value.versioning_enabled != null ? true : false
  }
}

resource "scaleway_object" "this" {
  for_each      = { for b in var.bucket : b.name => b if contains(keys(b), "object") && b.object != null }
  bucket        = scaleway_object_bucket.this[each.key].id
  key           = lookup(each.value, "key")
  file          = lookup(each.value, "file")
  hash          = join("/", [path.cwd, "files", filemd5(lookup(each.value, "file"))])
  storage_class = lookup(each.value, "storage_class")
  visibility    = lookup(each.value, "visibility")
  metadata      = merge(lookup(each.value, "metadata"), var.metadata)
  tags          = merge(lookup(each.value, "tags"), var.tags)
  project_id    = data.scaleway_account_project.this.project_id
}

resource "scaleway_object_bucket_acl" "this" {
  for_each              = { for c in var.bucket : c.name => c if contains(keys(c), "acl") && c.acl != null }
  bucket                = scaleway_object_bucket.this[each.key].id
  acl                   = lookup(each.value, "acl")
  expected_bucket_owner = lookup(each.value, "expected_bucket_owner")
  region                = lookup(each.value, "region")
  project_id            = data.scaleway_account_project.this.project_id

  dynamic "access_control_policy" {
    for_each = lookup(each.value, "access_control_policy")
    content {
      dynamic "grant" {
        for_each = try(lookup(access_control_policy.value, "grant") == null ? [] : ["grant"])
        content {
          permission = lookup(grant.value, "permission")

          dynamic "grantee" {
            for_each = try(lookup(grant.value, "grantee") == null ? [] : ["grantee"])
            content {
              id   = lookup(grantee.value, "id")
              type = lookup(grantee.value, "type")
            }
          }
        }
      }
      dynamic "owner" {
        for_each = try(lookup(access_control_policy.value, "owner") == null ? [] : ["owner"])
        content {
          id           = lookup(owner.value, "id")
          display_name = lookup(owner.value, "display_name")
        }
      }
    }
  }
}

resource "scaleway_object_bucket_lock_configuration" "this" {
  for_each = { for d in var.bucket : d.name => d if contains(keys(d), "default_retention") && d.default_retention != null }
  bucket   = scaleway_object_bucket.this[each.key].id

  rule {
    dynamic "default_retention" {
      for_each = lookup(each.value, "default_retention")
      content {
        mode  = lookup(default_retention.value, "mode")
        days  = lookup(default_retention.value, "days")
        years = lookup(default_retention.value, "years")
      }
    }
  }
}