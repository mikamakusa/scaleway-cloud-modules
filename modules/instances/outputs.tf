output "images" {
  value = {
    for a in scaleway_instance_image.this : a => {
      id           = a.id
      architecture = a.architecture
      name         = a.name
    }
  }
}

output "ips" {
  value = {
    for a in scaleway_instance_ip.this : a => {
      id      = a.id
      address = a.address
      prefix  = a.prefix
      reverse = a.reverse
    }
  }
}

output "ip_reverse_dns" {
  value = {
    for a in scaleway_instance_ip_reverse_dns.this : a => {
      id      = a.id
      reverse = a.reverse
    }
  }
}

output "placement_groups" {
  value = {
    for a in scaleway_instance_placement_group.this : a => {
      id               = a.id
      policy_respected = a.policy_respected
      policy_mode      = a.policy_mode
      policy_type      = a.policy_type
    }
  }
}

output "private_nics" {
  value = {
    for a in scaleway_instance_private_nic.this : a => {
      id = a.id
      mac_address = a.mac_address
    }
  }
}

output "security_groups" {
  value = {
    for a in scaleway_instance_security_group.this : a => {
      id = a.id
    }
  }
}

output "security_group_ruless" {
  value = {
    for a in scaleway_instance_security_group_rules.this : a => {
      id = a.id
    }
  }
}

output "servers" {
  value = {
    for a in scaleway_instance_server.this : a => {
      id = a.id
    }
  }
}

output "snapshots" {
  value = {
    for a in scaleway_instance_snapshot.this : a => {
      id = a.id
      size = a.size_in_gb
    }
  }
}

output "user_datas" {
  value = {
    for a in scaleway_instance_user_data.this : a => {
      id = a.id
    }
  }
}

output "volumes" {
  value = {
    for a in scaleway_instance_volume.this : a => {
      id = a.id
    }
  }
}
