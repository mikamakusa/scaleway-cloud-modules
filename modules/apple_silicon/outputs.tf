output "vpc" {
  description = "Informations relatives aux VPC."
  value = {
    for a in scaleway_vpc.this : a => {
      id         = a.id
      created_at = a.created_at
      updated_at = a.updated_at
      is_default = a.is_default
    }
  }
}

output "private_network" {
  description = "Informations relatives aux réseaux privés."
  value = {
    for a in scaleway_vpc_private_network.this : a => {
      id                   = a.id
      created_at           = a.created_at
      updated_at           = a.updated_at
      ipv4_subnet          = a.ipv4_subnet[0].subnet
      ipv4_subnet_id       = a.ipv4_subnet[0].id
      ipv4_subnet_address  = a.ipv4_subnet[0].address
      ipv4_subnet_mask     = a.ipv4_subnet[0].subnet_mask
      ipv6_subnets         = a.ipv6_subnets[0].subnet
      ipv6_subnets_id      = a.ipv6_subnets[0].id
      ipv6_subnets_address = a.ipv6_subnets[0].address
    }
  }
}

output "apple_silicon_server" {
  description = "Informations relatives aux serveurs Apple Silicon!,"
  value = {
    for a in scaleway_apple_silicon_server.this : a => {
      id                     = a.id
      state                  = a.state
      vnc_url                = a.vnc_url
      enable_vpc             = a.enable_vpc
      created_at             = a.created_at
      updated_at             = a.updated_at
      organization_id        = a.organization_id
      private_network_vlan   = a.private_network[0].vlan
      private_network_status = a.private_network[0].status
    }
  }
}