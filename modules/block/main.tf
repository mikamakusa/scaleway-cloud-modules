resource "scaleway_object_bucket" "this" {
  for_each      = { for bucket in var.buckets : bucket.name => bucket }
  name          = join("-", [each.value.name, "bucket"])
  tags          = each.value.tags
  region        = each.value.region
  force_destroy = each.value.force_destroy
  project_id    = data.scaleway_account_project.this.project_id

  dynamic "cors_rule" {
    for_each = var.cors_rule != null ? [""] : []
    content {
      allowed_methods = var.cors_rule.allowed_methods
      allowed_origins = var.cors_rule.allowed_origins
      allowed_headers = var.cors_rule.allowed_headers
      expose_headers  = var.cors_rule.expose_headers
      max_age_seconds = var.cors_rule.max_age_seconds
    }
  }

  dynamic "versioning" {
    for_each = each.value.versioning != false ? [""] : []
    content {
      enabled = true
    }
  }

  dynamic "lifecycle_rule" {
    for_each = var.lifecycle_rule != null ? [""] : []
    content {
      enabled                                = var.lifecycle_rule.enabled
      abort_incomplete_multipart_upload_days = var.lifecycle_rule.abort_incomplete_multipart_upload_days
      id                                     = var.lifecycle_rule.id
      tags                                   = merge(var.tags, var.lifecycle_rule.tags)

      transition {
        storage_class = var.lifecycle_rule.storage_class
        days          = var.lifecycle_rule.transition_days
      }

      expiration {
        days = var.lifecycle_rule.expiration_days
      }
    }
  }
}

resource "scaleway_object" "this" {
  for_each         = { for bucket in var.buckets : bucket.name => bucket if contains(keys(bucket), "objects") && bucket.objects != null }
  bucket           = scaleway_object_bucket.this[each.key].id
  key              = lookup(each.value, "key")
  file             = lookup(each.value, "file")
  content          = lookup(each.value, "content")
  content_base64   = lookup(each.value, "content_base64")
  hash             = join("/", [path.cwd, "files", filemd5(lookup(each.value, "file"))])
  storage_class    = lookup(each.value, "storage_class")
  visibility       = lookup(each.value, "visibility")
  metadata         = merge(lookup(each.value, "metadata"), var.metadata)
  tags             = merge(lookup(each.value, "tags"), var.tags)
  sse_customer_key = lookup(each.value, "sse_customer_key")
  project_id       = data.scaleway_account_project.this.project_id
}

resource "scaleway_block_volume" "this" {
  for_each   = { for volume in var.block_volumes : volume.iops => volume }
  iops       = each.value.iops
  size_in_gb = each.value.size_in_gb
  name       = each.value.name
  tags       = each.value.tags
  zone       = each.value.zone
  project_id = data.scaleway_account_project.this.project_id
}

resource "scaleway_block_snapshot" "this" {
  for_each   = { for volume in var.block_volumes : volume.iops => volume if contains(keys(volume), "snapshots") && volume.snapshots != null }
  name       = lookup(each.value, "name")
  volume_id  = scaleway_block_volume.this[each.key].id
  zone       = lookup(each.value, "zone")
  tags       = lookup(each.value, "tags")
  project_id = data.scaleway_account_project.this.project_id

  dynamic "import" {
    for_each = lookup(each.value, "import") != null ? [""] : []
    content {
      bucket = scaleway_object_bucket.this[lookup(each.value, "bucket_name")].id
      key    = join("/", [lookup(each.value, "folder"), lookup(each.value, "file")])
    }
  }

  dynamic "export" {
    for_each = lookup(each.value, "export") != null ? [""] : []
    content {
      bucket = scaleway_object_bucket.this[lookup(each.value, "bucket_name")].id
      key    = join("/", [lookup(each.value, "folder"), lookup(each.value, "file")])
    }
  }
}