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

output "block_volume" {
  description = "Informations relatives aux volumes de type Block."
  value = {
    for a in scaleway_block_volume.this : a => {
      id         = a.id
      name       = a.name
      size_in_gb = a.size_in_gb
    }
  }
}
output "block_snapshot" {
  description = "Informations relatives aux volumes de type Block."
  value = {
    for a in scaleway_block_snapshot.this : a => {
      id   = a.id
      name = a.name
    }
  }
}
output "lb_ip" {
  description = "Informations relatives aux ip réservées aux load balancers."
  value = {
    for a in scaleway_lb_ip.this : a => {
      id         = a.id
      lb_id      = a.lb_id
      ip_address = a.ip_address
      is_ipv6    = a.is_ipv6
    }
  }
}
output "lb" {
  description = "Informations relatives aux load balancers."
  value = {
    for a in scaleway_lb.this : a => {
      id              = a.id
      ip_address      = a.ip_address
      name            = a.name
      organization_id = a.organization_id
    }
  }
}
output "lb_backend" {
  description = "Informations relatives aux backends des load balancers."
  value = {
    for a in scaleway_lb_backend.this : a => {
      id   = a.id
      name = a.name
    }
  }
}
output "autoscaling_instance_template" {
  description = "Informations relatives aux templates d'autoscaling group."
  value = {
    for a in scaleway_autoscaling_instance_template.this : a => {
      id         = a.id
      created_at = a.created_at
      updated_at = a.updated_at
    }
  }
}
output "autoscaling_instance_group" {
  description = "Informations relatives aux autoscaling group."
  value = {
    for a in scaleway_autoscaling_instance_group.this : a => {
      id         = a.id
      created_at = a.created_at
      updated_at = a.updated_at
    }
  }
}
output "autoscaling_instance_policy" {
  description = "Informations relatives aux policies d'autoscaling group."
  value = {
    for a in scaleway_autoscaling_instance_policy.this : a => {
      id = a.id
    }
  }
}