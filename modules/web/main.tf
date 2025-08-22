resource "scaleway_webhosting" "this" {
  for_each   = { for hosting in var.webhosting : hosting.domain => hosting }
  domain     = each.value.domain
  email      = each.value.email
  offer_id   = data.scaleway_webhosting_offer.this.offer_id
  option_ids = each.value.option_ids
  tags       = concat(var.tags, each.value.tags)
  region     = var.region
  project_id = data.scaleway_account_project.this.id
}