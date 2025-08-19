data "scaleway_account_project" "this" {
  name = var.project_name
}

data "scaleway_baremetal_os" "this" {
  count   = var.os ? 1 : 0
  zone    = var.os.zone
  name    = var.os.name
  version = var.os.version
  os_id   = var.os.os_id
}

data "scaleway_baremetal_offer" "this" {
  count               = var.offer ? 1 : 0
  name                = var.offer.name
  subscription_period = var.offer.subscription_period
  offer_id            = var.offer.offer_id
  zone                = var.offer.zone
  include_disabled    = var.offer.include_disabled
}

data "scaleway_iam_ssh_key" "this" {
  count      = var.ssh_key ? 1 : 0
  name       = var.ssh_key.name
  ssh_key_id = var.ssh_key.ssh_key_id
  project_id = data.scaleway_account_project.this.id
}

data "scaleway_baremetal_option" "this" {
  count     = length(var.option)
  name      = lookup(var.option[count.index], "name")
  option_id = lookup(var.option[count.index], "option_id")
  zone      = lookup(var.option[count.index], "zone")
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
  private_network_id = data.scaleway_vpc_private_network.this[0].id
}