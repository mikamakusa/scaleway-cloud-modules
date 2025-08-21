data "scaleway_account_project" "this" {
  name = var.project_name
}

data "scaleway_vpc" "this" {
  count           = var.vpc ? 1 : 0
  name            = var.vpc.name
  is_default      = var.vpc.is_default
  organization_id = var.vpc.organization_id
  project_id      = data.scaleway_account_project.this.id
}

data "scaleway_vpc_private_network" "this" {
  count      = var.private_network ? 1 : 0
  vpc_id     = data.scaleway_vpc.this[0].id
  name       = var.private_network.name
  project_id = data.scaleway_account_project.this.id
}

data "scaleway_ipam_ip" "this" {
  for_each   = { for ip in var.ips : ip.id => ip }
  ipam_ip_id = scaleway_ipam_ip.this[each.key].id
}