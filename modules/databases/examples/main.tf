provider "scaleway" {}

variable "instance_user_name" {
  type      = string
  sensitive = true
}

variable "instance_password" {
  type      = string
  sensitive = true
}

variable "username" {
  type      = string
  sensitive = true
}

variable "password" {
  type      = string
  sensitive = true
}

module "databases" {
  source = "../"
  instance = [{
    name           = "test-rdb"
    node_type      = "DB-DEV-S"
    engine         = "PostgreSQL-15"
    is_ha_cluster  = true
    disable_backup = true
    user_name      = var.instance_user_name
    password       = var.instance_password
    database_backup = [{
      expires_at = "2022-06-16T07:48:44Z"
    }]
    user = [{
      name     = var.username
      password = var.password
      is_admin = false
    }]
    privilege = [{
      permission    = "all"
    }]
  }]
}
