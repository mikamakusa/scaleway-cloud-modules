resource "scaleway_vpc" "this" {
  count                            = length(var.vpc)
  name                             = lookup(var.vpc[count.index], "name")
  tags                             = concat(var.tags, lookup(var.vpc[count.index], "tags"))
  enable_routing                   = lookup(var.vpc[count.index], "enable_routing")
  enable_custom_routes_propagation = lookup(var.vpc[count.index], "enable_custom_routes_propagation")
  region                           = var.region
  project_id                       = data.scaleway_account_project.this.id
}

resource "scaleway_vpc_private_network" "this" {
  count                            = length(var.private_network)
  name                             = lookup(var.private_network[count.index], "name")
  tags                             = concat(var.tags, lookup(var.private_network[count.index], "tags"))
  region                           = var.region
  vpc_id                           = element(scaleway_vpc.this.*.id, lookup(var.private_network[count.index], "vpc_id"))
  enable_default_route_propagation = lookup(var.private_network[count.index], "enable_default_route_propagation")
  project_id                       = data.scaleway_account_project.this.id

  dynamic "ipv4_subnet" {
    for_each = lookup(var.private_network[count.index], "ipv4_subnet") != null ? [""] : []
    content {
      subnet = lookup(var.private_network[count.index], "ipv4_subnet")
    }
  }

  dynamic "ipv6_subnets" {
    for_each = lookup(var.private_network[count.index], "ipv6_subnets") != null ? [""] : []
    iterator = ipv6
    content {
      subnet = lookup(ipv6.value, "subnet")
    }
  }
}

resource "scaleway_vpc_acl" "this" {
  count          = length(var.vpc) == "0" ? "0" : length(var.acl)
  default_policy = lookup(var.acl[count.index], "default_policy")
  vpc_id         = element(scaleway_vpc.this.*.id, lookup(var.acl[count.index], "vpc_id"))
  is_ipv6        = lookup(var.acl[count.index], "is_ipv6")
  region         = var.region

  dynamic "rules" {
    for_each = lookup(var.acl[count.index], "rules") != null ? [""] : []
    content {
      action        = lookup(rules.value, "action")
      description   = lookup(rules.value, "description")
      destination   = lookup(rules.value, "destination")
      dst_port_high = lookup(rules.value, "dst_port_high")
      dst_port_low  = lookup(rules.value, "dst_port_low")
      protocol      = lookup(rules.value, "protocol")
      source        = lookup(rules.value, "source")
      src_port_high = lookup(rules.value, "src_port_high")
      src_port_low  = lookup(rules.value, "src_port_low")
    }
  }
}

resource "scaleway_vpc_gateway_network" "this" {
  count              = length(var.public_gateway) == "0" && length(var.private_network) == "0" ? "0" : length(var.gateway_network)
  gateway_id         = element(scaleway_vpc_public_gateway.this.*.id, lookup(var.gateway_network[count.index], "gateway_id"))
  private_network_id = element(scaleway_vpc_private_network.this.*.id, lookup(var.gateway_network[count.index], "private_network_id"))
  enable_masquerade  = lookup(var.gateway_network[count.index], "enable_masquerade")
  zone               = lookup(var.gateway_network[count.index], "zone")
}

resource "scaleway_vpc_public_gateway" "this" {
  for_each             = { for gateway in var.public_gateway : gateway.name => gateway }
  type                 = each.value.type
  name                 = each.value.name
  tags                 = each.value.tags
  zone                 = each.value.zone
  ip_id                = each.value.ip_id
  bastion_enabled      = each.value.bastion_enabled
  bastion_port         = each.value.bastion_port
  allowed_ip_ranges    = each.value.allowed_ip_ranges
  enable_smtp          = each.value.enable_smtp
  refresh_ssh_keys     = each.value.refresh_ssh_keys
  project_id           = data.scaleway_account_project.this.id
}

resource "scaleway_vpc_public_gateway_dhcp" "this" {
  for_each             = { for dhcp in var.public_gateway_dhcp : dhcp.subnet => dhcp }
  subnet               = each.value.subnet
  address              = each.value.address
  dns_local_name       = each.value.dns_local_name
  dns_search           = each.value.dns_search
  dns_servers_override = each.value.dns_servers_override
  enable_dynamic       = each.value.enable_dynamic
  pool_high            = each.value.pool_high
  pool_low             = each.value.pool_low
  rebind_timer         = each.value.rebind_timer
  renew_timer          = each.value.renew_timer
  valid_lifetime       = each.value.valid_lifetime
  zone                 = each.value.zone
  project_id           = data.scaleway_account_project.this.id
}

resource "scaleway_vpc_public_gateway_dhcp_reservation" "this" {
  count              = length(var.gateway_network) == "0" ? "0" : length(var.public_gateway_dhcp_reservation)
  gateway_network_id = element(scaleway_vpc_gateway_network.this.*.id, lookup(var.public_gateway_dhcp_reservation[count.index], "gateway_network_id"))
  ip_address         = lookup(var.public_gateway_dhcp_reservation[count.index], "ip_address")
  mac_address        = lookup(var.public_gateway_dhcp_reservation[count.index], "mac_address")
  zone               = lookup(var.public_gateway_dhcp_reservation[count.index], "zone")
}

resource "scaleway_vpc_public_gateway_ip" "this" {
  count      = length(var.public_gateway_ip)
  reverse    = lookup(var.public_gateway_ip[count.index], "reverse")
  tags       = concat(var.tags, lookup(var.public_gateway_ip[count.index], "tags"))
  zone       = lookup(var.public_gateway_ip[count.index], "zone")
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_vpc_public_gateway_ip_reverse_dns" "this" {
  count         = length(var.public_gateway_ip) == "0" ? "0" : length(var.public_gateway_ip_reverse_dns)
  gateway_ip_id = element(scaleway_vpc_public_gateway_ip.this.*.id, lookup(var.public_gateway_ip_reverse_dns[count.index], "gateway_ip_id"))
  reverse       = lookup(var.public_gateway_ip_reverse_dns[count.index], "reverse")
  zone          = lookup(var.public_gateway_ip_reverse_dns[count.index], "zone")
}

resource "scaleway_vpc_public_gateway_pat_rule" "this" {
  count        = length(var.public_gateway) == "0" ? "0" : length(var.public_gateway_pat_rule)
  gateway_id   = element(scaleway_vpc_public_gateway.this.*.id, lookup(var.public_gateway_pat_rule[count.index], "gateway_id"))
  private_ip   = element(scaleway_vpc_public_gateway_dhcp_reservation.this.*.ip_address, lookup(var.public_gateway_pat_rule[count.index], "private_ip"))
  private_port = lookup(var.public_gateway_pat_rule[count.index], "private_port")
  public_port  = lookup(var.public_gateway_pat_rule[count.index], "public_port")
  zone         = lookup(var.public_gateway_pat_rule[count.index], "zone")
}

resource "scaleway_vpc_route" "this" {
  count                      = length(var.vpc) == "0" ? "0" : length(var.route)
  vpc_id                     = element(scaleway_vpc.this.*.id, lookup(var.route[count.index], "vpc_id"))
  description                = lookup(var.route[count.index], "description")
  tags                       = concat(var.tags, lookup(var.route[count.index], "tags"))
  destination                = lookup(var.route[count.index], "destination")
  nexthop_resource_id        = lookup(var.route[count.index], "nexthop_resource_id")
  nexthop_private_network_id = lookup(var.route[count.index], "nexthop_private_network_id")
  region                     = var.region
}