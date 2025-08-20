resource "scaleway_instance_image" "this" {
  count                 = length(var.images)
  root_volume_id        = element(scaleway_instance_snapshot.this.*.id, lookup(var.images[count.index], "root_volume_id"))
  additional_volume_ids = [element(scaleway_instance_snapshot.this.*.id, lookup(var.images[count.index], "additional_volume_ids"))]
  architecture          = lookup(var.images[count.index], "architecture")
  name                  = lookup(var.images[count.index], "name")
  public                = lookup(var.images[count.index], "public")
  tags                  = concat(var.tags, lookup(var.images[count.index], "tags"))
  zone                  = lookup(var.images[count.index], "zone")
  project_id            = data.scaleway_account_project.this.id
}

resource "scaleway_instance_ip" "this" {
  for_each   = { for ip in var.ips : ip.type => ip }
  type       = each.value.type
  zone       = each.value.zone
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_instance_ip_reverse_dns" "this" {
  for_each = { for ip in var.ips : ip.type => ip if contains(keys(ip), "is_reverse") && ip.is_reverse == true }
  ip_id    = scaleway_instance_ip.this[each.key].id
  reverse  = each.value.reverse
  zone     = each.value.zone
}

resource "scaleway_instance_placement_group" "this" {
  count       = length(var.placement_groups)
  name        = lookup(var.placement_groups[count.index], "name")
  policy_mode = lookup(var.placement_groups[count.index], "policy_mode")
  policy_type = lookup(var.placement_groups[count.index], "policy_type")
  zone        = lookup(var.placement_groups[count.index], "zone")
  tags        = concat(var.tags, lookup(var.placement_groups[count.index], "tags"))
  project_id  = data.scaleway_account_project.this.id
}

resource "scaleway_instance_private_nic" "this" {
  count              = length(var.private_nics)
  private_network_id = data.scaleway_vpc_private_network.this[0].id
  server_id          = element(scaleway_instance_server.this.*.id, lookup(var.private_nics[count.index], "server_id"))
  tags               = lookup(var.private_nics[count.index], "tags")
  zone               = lookup(var.private_nics[count.index], "zone")
}

resource "scaleway_instance_security_group" "this" {
  count                   = length(var.security_groups)
  name                    = lookup(var.security_groups[count.index], "name")
  description             = lookup(var.security_groups[count.index], "description")
  inbound_default_policy  = lookup(var.security_groups[count.index], "inbound_default_policy")
  outbound_default_policy = lookup(var.security_groups[count.index], "outbound_default_policy")
  zone                    = lookup(var.security_groups[count.index], "zone")
  enable_default_security = lookup(var.security_groups[count.index], "enable_default_security")
  stateful                = lookup(var.security_groups[count.index], "stateful")
  external_rules          = lookup(var.security_groups[count.index], "external_rules")
  project_id              = data.scaleway_account_project.this.id
}

resource "scaleway_instance_security_group_rules" "this" {
  count             = length(var.security_groups) == "0" ? "0" : length(var.rules)
  security_group_id = element(scaleway_instance_security_group.this.*.id, lookup(var.rules[count.index], "security_group_id"))

  dynamic "inbound_rule" {
    for_each = var.inbound_rule != null ? [""] : []
    content {
      action     = var.inbound_rule.action
      port       = var.inbound_rule.port
      port_range = var.inbound_rule.port_range
      protocol   = var.inbound_rule.protocol
      ip_range   = var.inbound_rule.ip_range
    }
  }

  dynamic "outbound_rule" {
    for_each = var.outbound_rule != null ? [""] : []
    content {
      action     = var.outbound_rule.action
      port       = var.outbound_rule.port
      port_range = var.outbound_rule.port_range
      protocol   = var.outbound_rule.protocol
      ip_range   = var.outbound_rule.ip_range
    }
  }
}

resource "scaleway_instance_server" "this" {
  count                  = length(var.servers)
  type                   = lookup(var.servers[count.index], "type")
  image                  = lookup(var.servers[count.index], "image")
  name                   = lookup(var.servers[count.index], "name")
  tags                   = concat(var.tags, lookup(var.servers[count.index], "tags"))
  security_group_id      = element(scaleway_instance_security_group.this.*.id, lookup(var.servers[count.index], "security_group_id"))
  placement_group_id     = element(scaleway_instance_placement_group.this.*.id, lookup(var.servers[count.index], "placement_group_id"))
  additional_volume_ids  = [element(scaleway_instance_volume.this.*.id, lookup(var.servers[count.index], "additional_volume_ids"))]
  enable_dynamic_ip      = lookup(var.servers[count.index], "enable_dynamic_ip")
  ip_id                  = scaleway_instance_ip.this[0].id
  state                  = lookup(var.servers[count.index], "state")
  boot_type              = lookup(var.servers[count.index], "boot_type")
  replace_on_type_change = lookup(var.servers[count.index], "replace_on_type_change")
  protected              = lookup(var.servers[count.index], "protected")
  zone                   = lookup(var.servers[count.index], "zone")
  project_id             = data.scaleway_account_project.this.id

  dynamic "private_network" {
    for_each = var.private_network != null ? [""] : []
    content {
      pn_id = data.scaleway_vpc_private_network.this[0].id
    }
  }

  dynamic "root_volume" {
    for_each = lookup(var.servers[count.index], "root_volume") != null ? [""] : []
    iterator = volume
    content {
      volume_id   = element(scaleway_instance_volume.this.*.id, lookup(volume.value, "volume_id"))
      volume_type = lookup(volume.value, "volume_type")
      sbs_iops    = lookup(volume.value, "sbs_iops")
      size_in_gb  = lookup(volume.value, "size_in_gb")
    }
  }
}

resource "scaleway_instance_snapshot" "this" {
  count      = length(var.snapshots)
  volume_id  = element(scaleway_instance_volume.this.*.id, lookup(var.snapshots[count.index], "volume_id"))
  type       = lookup(var.snapshots[count.index], "type")
  name       = lookup(var.snapshots[count.index], "name")
  zone       = lookup(var.snapshots[count.index], "zone")
  tags       = concat(var.tags, lookup(var.snapshots[count.index], "tags"))
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_instance_user_data" "this" {
  count     = length(var.user_data)
  key       = lookup(var.user_data[count.index], "key")
  server_id = element(scaleway_instance_server.this.*.id, lookup(var.user_data[count.index], "server_id"))
  value     = lookup(var.user_data[count.index], "value")
}

resource "scaleway_instance_volume" "this" {
  count            = length(var.volumes)
  type             = lookup(var.volumes[count.index], "type")
  size_in_gb       = lookup(var.volumes[count.index], "size_in_gb")
  name             = lookup(var.volumes[count.index], "name")
  zone             = lookup(var.volumes[count.index], "zone")
  tags             = concat(var.tags, lookup(var.volumes[count.index], "tags"))
  project_id       = data.scaleway_account_project.this.id
}