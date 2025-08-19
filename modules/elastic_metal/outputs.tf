output "servers" {
  value = {
    for a in scaleway_baremetal_server.this : a => {
      offer_id                   = a.offer_id
      offer_name                 = a.offer_name
      os_name                    = a.os_name
      private_network_id         = a.private_network[0].id
      private_network_mapping_id = a.private_network[0].mapping_id
      private_network_vlan       = a.private_network[0].vlan
      private_network_status     = a.private_network[0].status
      private_ips_id             = a.private_ips[0].id
      private_ips_address        = a.private_ips[0].address
      domain                     = a.domain
      organization_id            = a.organization_id
    }
  }
}

output "ips" {
  value = {
    for a in scaleway_flexible_ip.this : a => {
      id              = a.id
      ip_address      = a.ip_address
      server_id       = a.server_id
      status          = a.status
      created_at      = a.created_at
      updated_at      = a.updated_at
      organization_id = a.organization_id
    }
  }
}

output "ip_mac_addresses" {
  value = {
    for a in scaleway_flexible_ip_mac_address.this : a => {
      id         = a.id
      zone       = a.zone
      status     = a.status
      created_at = a.created_at
      updated_at = a.updated_at
    }
  }
}
