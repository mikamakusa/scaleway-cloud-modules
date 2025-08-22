resource "scaleway_tem_domain" "this" {
  for_each   = { for domain in var.domains : domain.name => domain }
  accept_tos = each.value.accept_tos
  name       = each.value.name
  region     = each.value.region
  autoconfig = each.value.autoconfig
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_tem_blocked_list" "this" {
  for_each   = { for domain in var.domains : domain.name => domain if contains(keys(domain), "blocked_lists") && domain.blocked_lists != null }
  domain_id  = scaleway_tem_domain.this[each.key].id
  email      = lookup(each.value, "email")
  type       = lookup(each.value, "type")
  reason     = lookup(each.value, "reason")
  region     = each.value.region
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_tem_domain_validation" "this" {
  for_each  = { for domain in var.domains : domain.name => domain if contains(keys(domain), "domain_validations") && domain.domain_validations != null }
  domain_id = scaleway_tem_domain.this[each.key].id
  region    = each.value.region
  timeout   = lookup(each.value, "timeout")
}

resource "scaleway_tem_webhook" "this" {
  for_each    = { for domain in var.domains : domain.name => domain if contains(keys(domain), "webhooks") && domain.webhooks != null }
  domain_id   = scaleway_tem_domain.this[each.key].id
  event_types = lookup(each.value, "event_types")
  sns_arn     = lookup(each.value, "sns_arn")
  name        = lookup(each.value, "name")
  region      = each.value.region
  project_id  = data.scaleway_account_project.this.id
}