# scaleway_vpc
output "vpc" {
  value = {
    for a in scaleway_vpc.this : a => {
      id         = a.id
      is_default = a.is_default
    }
  }
}

# scaleway_vpc_private_network
output "private_network" {
  value = {
    for a in scaleway_vpc_private_network.this : a => {
      id           = a.id
      ipv4_subnet  = a.ipv4_subnet[0].subnet
      ipv6_subnets = a.ipv6_subnets[0].subnet
    }
  }
}

# scaleway_vpc_acl
output "acl" {
  value = {
    for a in scaleway_vpc_acl.this : a => {
      id = a.id
    }
  }
}

# scaleway_vpc_gateway_network
output "gateway_network" {
  value = {
    for a in scaleway_vpc_gateway_network.this : a => {
      id                = a.id
      mac_addres        = a.mac_address
      enable_masquerade = a.enable_masquerade
      status            = a.status
    }
  }
}

# scaleway_vpc_public_gateway
output "public_gateway" {
  value = {
    for a in scaleway_vpc_public_gateway.this : a => {
      id     = a.id
      status = a.status
      name   = a.name
    }
  }
}

# scaleway_vpc_public_gateway_dhcp
output "public_gateway_dhcp" {
  value = {
    for a in scaleway_vpc_public_gateway_dhcp.this : a => {
      id = a.id
    }
  }
}

# scaleway_vpc_public_gateway_dhcp_reservation
output "public_gateway_dhcp_reservation" {
  value = {
    for a in scaleway_vpc_public_gateway_dhcp_reservation.this : a => {
      id       = a.id
      hostname = a.hostname
      type     = a.type
    }
  }
}

# scaleway_vpc_public_gateway_ip
output "public_gateway_ip" {
  value = {
    for a in scaleway_vpc_public_gateway_ip.this : a => {
      id      = a.id
      address = a.address
      reverse = a.reverse
    }
  }
}

# scaleway_vpc_public_gateway_ip_reverse_dns
output "public_gateway_ip_reverse_dns" {
  value = {
    for a in scaleway_vpc_public_gateway_ip_reverse_dns.this : a => {
      id = a.id
    }
  }
}

# scaleway_vpc_public_gateway_pat_rule
output "public_gateway_pat_rule" {
  value = {
    for a in scaleway_vpc_public_gateway_pat_rule.this : a => {
      id = a.id
    }
  }
}

# scaleway_vpc_route
output "route" {
  value = {
    for a in scaleway_vpc_route.this : a => {
      id = a.id
    }
  }
}
