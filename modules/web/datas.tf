data "scaleway_account_project" "this" {
  name = var.project_name
}

data "scaleway_webhosting_offer" "this" {
  name          = var.webhosting_offer.name
  control_panel = var.webhosting_offer.control_panel
  offer_id      = var.webhosting_offer.offer_id
  region        = var.region
}