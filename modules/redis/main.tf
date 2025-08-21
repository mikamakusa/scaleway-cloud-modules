resource "scaleway_redis_cluster" "this" {
  for_each     = var.clusters
  name         = each.key
  node_type    = each.value.node_type
  password     = each.value.password
  user_name    = each.value.user_name
  version      = each.value.version
  tags         = concat(var.tags, each.value.tags)
  zone         = each.value.zone
  cluster_size = each.value.cluster_size
  tls_enabled  = each.value.tls_enabled
  project_id   = data.scaleway_account_project.this.id
  settings     = each.value.settings

  dynamic "acl" {
    for_each = var.acls != null ? [""] : []
    content {
      ip          = var.acls.ip
      description = var.acls.description
    }
  }

  dynamic "private_network" {
    for_each = var.private_network != null ? [""] : []
    content {
      id = data.scaleway_vpc_private_network.this[0].id
    }
  }
}