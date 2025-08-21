resource "scaleway_ipam_ip" "this" {
  for_each   = { for ip in var.ips : ip.id => ip }
  address    = each.value.address
  tags       = each.value.tags
  is_ipv6    = each.value.is_ipv6
  region     = each.value.region
  project_id = data.scaleway_account_project.this.id

  source {
    private_network_id = data.scaleway_vpc_private_network.this[0].id
  }
}

resource "scaleway_ipam_ip_reverse_dns" "this" {
  for_each   = { for ip in var.ips : ip.id => ip if contains(keys(ip), "reverse_dns") && ip.reverse_dns != null }
  address    = cidrhost(data.scaleway_ipam_ip.this[0].address_cidr, lookup(each.value, "address"))
  hostname   = lookup(each.value, "hostname")
  ipam_ip_id = scaleway_ipam_ip.this[each.key].id
  region     = each.value.region
}