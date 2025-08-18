resource "scaleway_vpc" "this" {
  for_each                         = { for vpc in var.vpcs : vpc.name => vpc }
  name                             = each.value.name
  tags                             = each.value.tags
  enable_routing                   = each.value.enable_routing
  enable_custom_routes_propagation = each.value.enable_custom_routes_propagation
  region                           = each.value.region
  project_id                       = data.scaleway_account_project.this.project_id
}

resource "scaleway_vpc_private_network" "this" {
  for_each                          = { for vpc in var.vpcs : vpc.name => vpc if contains(keys(vpc), "private_network") && vpc.private_network != null }
  name                              = lookup(each.value, "name")
  tags                              = lookup(each.value, "tags")
  project_id                        = data.scaleway_account_project.this.project_id
  vpc_id                            = scaleway_vpc.this[each.key].id
  region                            = scaleway_vpc.this[each.key].region
  enable_default_route_propagation = lookup(each.value, "enable_default_route_propagation")

  dynamic "ipv4_subnet" {
    for_each = var.ipv4_subnet != null ? [""] : []
    content {
      subnet = var.ipv4_subnet
    }
  }

  dynamic "ipv6_subnets" {
    for_each = var.ipv6_subnets != null ? [""] : []
    content {
      subnet = var.ipv6_subnets
    }
  }
}

resource "scaleway_apple_silicon_server" "this" {
  for_each         = { for server in var.apple_silicon_servers : server.type => server }
  type             = each.value.type
  name             = each.value.name
  zone             = each.value.zone
  project_id       = data.scaleway_account_project.this.project_id
  enable_vpc       = each.value.enable_vpc

  private_network {
    id = scaleway_vpc_private_network.this[0].id
  }
}