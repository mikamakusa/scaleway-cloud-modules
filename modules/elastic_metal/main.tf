resource "scaleway_baremetal_server" "this" {
  for_each                    = { for server in var.servers : server.offer => server }
  offer                       = var.offer != null ? data.scaleway_baremetal_offer.this[0].offer_id : each.value.offer
  os                          = var.os != null ? data.scaleway_baremetal_os.this[0].id : each.value.os
  ssh_key_ids                 = var.ssh_key != null ? [data.scaleway_iam_ssh_key.this[0].id] : [each.value.ssh_key_ids]
  user                        = sensitive(each.value.user)
  password                    = sensitive(each.value.password)
  service_password            = sensitive(each.value.service_password)
  service_user                = sensitive(each.value.service_user)
  reinstall_on_config_changes = each.value.reinstall_on_config_changes
  install_config_afterward    = each.value.install_config_afterward
  name                        = each.value.name
  hostname                    = each.value.hostname
  description                 = each.value.description
  tags                        = each.value.tags
  zone                        = each.value.zone
  partitioning                = each.value.partitioning
  protected                   = each.value.protected
  project_id                  = data.scaleway_account_project.this.id

  dynamic "options" {
    for_each = each.value.options != null ? [""] : []
    content {
      id         = element(data.scaleway_baremetal_option.this.*.option_id, lookup(each.value, "option_id"))
      expires_at = lookup(each.value, "expires_at")
    }
  }

  dynamic "private_network" {
    for_each = var.private_network != null ? [] : []
    content {
      id          = data.scaleway_vpc_private_network.this.id
      ipam_ip_ids = data.scaleway_ipam_ip.this.id
    }
  }
}

resource "scaleway_flexible_ip" "this" {
  for_each    = { for ip in var.flexible_ips : ip.zone => ip }
  description = each.value.description
  tags        = each.value.tags
  reverse     = each.value.reverse
  is_ipv6     = each.value.is_ipv6
  zone        = each.value.zone
  project_id  = data.scaleway_account_project.this.id
  server_id   = scaleway_baremetal_server.this[each.value.server_id].id
}

resource "scaleway_flexible_ip_mac_address" "this" {
  for_each       = { for ip in var.flexible_ips : ip.zone => ip if contains(keys(ip), "mac_addresses") && ip.mac_addresses != null }
  flexible_ip_id = scaleway_flexible_ip_mac_address.this[each.key].id
  type           = lookup(each.value, "type")
}