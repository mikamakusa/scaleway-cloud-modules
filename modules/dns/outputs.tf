output "records" {
  description = "Informations relatives aux dns records."
  value = {
    for a in scaleway_domain_record.this : a => {
      id              = a.id
      name            = a.name
      type            = a.type
      ttl             = a.ttl
      root_zone       = a.root_zone
      priority        = a.priority
      keep_empty_zone = a.keep_empty_zone
      fqdn            = a.fqdn
      dns_zone        = a.dns_zone
    }
  }
}

output "registrations" {
  description = "Informations relatives aux dns registrations."
  value = {
    for a in scaleway_domain_registration.this : a => {
      id                = a.id
      domain_names      = a.domain_names
      auto_renew        = a.auto_renew
      dnssec            = a.dnssec
      ds_record         = a.ds_record
      duration_in_years = a.duration_in_years
      owner_contact_id  = a.owner_contact_id
    }
  }
}

output "zones" {
  description = "Informations relatives aux dns zones."
  value = {
    for a in scaleway_domain_zone.this : a => {
      id         = a.id
      domain     = a.domain
      status     = a.status
      subdomain  = a.subdomain
      message    = a.message
      ns         = a.ns
      ns_default = a.ns_default
      ns_master  = a.ns_master
    }
  }
}
