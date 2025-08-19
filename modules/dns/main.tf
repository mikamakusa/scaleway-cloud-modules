resource "scaleway_domain_record" "this" {
  for_each   = { for record in var.records : record.dns_zone => record }
  data       = each.value.data
  dns_zone   = each.value.dns_zone
  type       = each.value.type
  name       = each.value.name
  ttl        = each.value.ttl
  priority   = each.value.priority
  project_id = data.scaleway_account_project.this.id

  dynamic "geo_ip" {
    for_each = var.geo_ip != null ? [""] : []
    content {
      matches {
        data       = var.geo_ip.data
        continents = var.geo_ip.continents
        countries  = var.geo_ip.countries
      }
    }
  }

  dynamic "weighted" {
    for_each = var.weighted != null ? [""] : []
    content {
      ip     = var.weighted.ip
      weight = var.weighted.weight
    }
  }

  dynamic "view" {
    for_each = var.view != null ? [""] : []
    content {
      data   = var.view.data
      subnet = var.view.subnet
    }
  }

  dynamic "http_service" {
    for_each = var.http_service != null ? [""] : []
    content {
      ips          = var.http_service.ips
      must_contain = var.http_service.must_contain
      strategy     = var.http_service.strategy
      url          = var.http_service.url
      user_agent   = var.http_service.user_agent
    }
  }
}

resource "scaleway_domain_registration" "this" {
  for_each          = { for registration in var.registrations : registration.domain_names => registration }
  domain_names      = each.value.domain_names
  auto_renew        = each.value.auto_renew
  dnssec            = each.value.dnssec
  duration_in_years = each.value.duration_in_years
  owner_contact_id  = each.value.owner_contact_id
  project_id        = data.scaleway_account_project.this.id

  dynamic "owner_contact" {
    for_each                    = var.owner_contact != null ? [""] : []
    content {
      address_line_1              = var.owner_contact.address_line_1
      city                        = var.owner_contact.city
      company_identification_code = var.owner_contact.company_identification_code
      country                     = var.owner_contact.country
      email                       = var.owner_contact.email
      firstname                   = var.owner_contact.firstname
      lastname                    = var.owner_contact.lastname
      legal_form                  = var.owner_contact.legal_form
      phone_number                = var.owner_contact.phone_number
      vat_identification_code     = var.owner_contact.vat_identification_code
      zip                         = var.owner_contact.zip
    }
  }
}

resource "scaleway_domain_zone" "this" {
  for_each   = { for zone in var.zones : zone.domain => zone }
  domain     = each.value.domain
  subdomain  = each.value.subdomain
  project_id = data.scaleway_account_project.this.id
}