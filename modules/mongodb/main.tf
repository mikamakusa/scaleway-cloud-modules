resource "scaleway_mongodb_instance" "this" {
  for_each          = { for a in var.instance : a.name => a }
  node_number       = each.value.node_number
  node_type         = each.value.node_type
  name              = each.value.name
  version           = each.value.version
  user_name         = each.value.user_name
  password          = sensitive(each.value.password)
  tags              = concat(each.value.tags, var.tags)
  volume_type       = each.value.volume_type
  volume_size_in_gb = each.value.volume_size_in_gb
  project_id        = data.scaleway_account_project.this.id

  dynamic "private_network" {
    for_each = var.private_network != null ? [""] : []
    content {
      pn_id = data.scaleway_vpc_private_network.this[0].id
    }
  }
}

resource "scaleway_mongodb_snapshot" "this" {
  for_each    = { for b in var.instance : b.name => b if contains(keys(b), "snapshot") && b.snapshot != null }
  expires_at  = lookup(each.value, "expires_at")
  instance_id = scaleway_mongodb_instance.this[each.key].id
  name        = lookup(each.value, "name")
  region      = lookup(each.value, "region")
}