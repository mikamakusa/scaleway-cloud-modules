provider "scaleway" {}

variable "user" {
  type      = string
  sensitive = true
}

variable "password" {
  type      = string
  sensitive = true
}

variable "service_password" {
  type      = string
  sensitive = true
}

variable "service_user" {
  type      = string
  sensitive = true
}

module "metal" {
  source = "../"
  offer = {
    zone = "fr-par-2"
    name = "EM-I220E-NVME"
  }
  os = {
    zone    = "fr-par-2"
    name    = "Ubuntu"
    version = "22.04 LTS (Jammy Jellyfish)"
  }
  option = [{
    id   = "0"
    zone = "fr-par-2"
    name = "Private Network"
    }, {
    id   = "4"
    zone = "fr-par-2"
    name = "Remote Access"
  }]
  servers = [{
    id                          = "7"
    zone                        = "fr-par-2"
    user                        = var.user
    password                    = var.password
    service_password            = var.service_password
    service_user                = var.service_user
    reinstall_on_config_changes = true
    name                        = "bm-1"
    options = [{
      option_id = "0"
      }, {
      option_id = "4"
    }]
  }]
  flexible_ips = [{
    server_id = "7"
    zone      = "fr-par-2"
    ip_mac_addresses = [{
      type = "kvm"
    }]
  }]
}
