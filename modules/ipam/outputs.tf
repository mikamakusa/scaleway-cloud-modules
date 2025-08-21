#scaleway_ipam_ip
output "ips" {
  value = {
    for a in scaleway_ipam_ip.this : a => {
      id                   = a.id
      resource_id          = a.resource[0].id
      resource_type        = a.resource[0].type
      resource_name        = a.resource[0].name
      resource_mac_address = a.resource[0].mac_address
      reverses_hostname    = a.reverses[0].hostname
      reverses_address     = a.reverses[0].address
      created_at           = a.created_at
      updated_at           = a.updated_at
      zone                 = a.zone
    }
  }
}

#scaleway_ipam_ip_reverse_dns
output "ip_reverse_dns" {
  value = {
    for a in scaleway_ipam_ip_reverse_dns.this : a => {
      id         = a.id
      ipam_ip_id = a.ipam_ip_id
    }
  }
}
