resource "scaleway_rdb_instance" "this" {
  for_each          = { for a in var.instance : a.name => a }
  engine            = each.value.engine
  node_type         = each.value.node_type
  volume_type       = each.value.volume_type
  volume_size_in_gb = each.value.volume_size_in_gb
  user_name         = sensitive(each.value.user_name)
  password          = sensitive(each.value.password)
  is_ha_cluster     = each.value.is_ha_cluster
  name              = join("-", [each.value.name, "instance"])
  tags = concat(
    var.tags,
    each.value.tags
  )
  region                    = each.value.region
  project_id                = data.scaleway_account_project.this.project_id
  encryption_at_rest        = each.value.encryption_at_rest
  backup_same_region        = each.value.backup_same_region
  backup_schedule_frequency = each.value.backup_schedule_frequency
  backup_schedule_retention = each.value.backup_schedule_retention
  disable_backup            = each.value.disable_backup
  settings                  = each.value.settings
  init_settings             = each.value.init_settings
}

resource "scaleway_rdb_database" "this" {
  for_each    = { for b in var.instance : b.name => b }
  instance_id = scaleway_rdb_instance.this[each.key].id
  name        = join("-", [each.value.name, "db"])
  region      = each.value.region
}

resource "scaleway_rdb_database_backup" "this" {
  for_each      = { for c in var.instance : c.name => c if contains(keys(c), "database_backup") && c.database_backup != null }
  database_name = scaleway_rdb_database.this[each.key].name
  instance_id   = scaleway_rdb_instance.this[each.key].id
  expires_at    = lookup(each.value, "expires_at")
  region        = each.value.region
}

resource "scaleway_rdb_privilege" "this" {
  for_each      = { for d in var.instance : d.name => d if contains(keys(d), "privilege") && d.privilege != null }
  database_name = scaleway_rdb_database.this[each.key].name
  instance_id   = scaleway_rdb_instance.this[each.key].id
  permission    = lookup(each.value, "permission")
  user_name     = lookup(each.value, "user_name")
  region        = each.value.region
}

resource "scaleway_rdb_read_replica" "this" {
  for_each      = { for e in var.instance : e.name => e if contains(keys(e), "read_replica") && e.read_replica != null }
  instance_id   = scaleway_rdb_instance.this[each.key].id
  same_zone     = lookup(each.value, "same_zone")
  region        = each.value.region
}

resource "scaleway_rdb_user" "this" {
  for_each    = { for f in var.instance : f.name => f if contains(keys(f), "user") && f.user != null }
  instance_id = scaleway_rdb_instance.this[each.key].id
  name        = sensitive(lookup(each.value, "name"))
  password    = sensitive(lookup(each.value, "password"))
  is_admin    = lookup(each.value, "is_admin")
  region      = each.value.region
}

resource "scaleway_rdb_acl" "this" {
  for_each    = { for g in var.instance : g.name => g if contains(keys(g), "acl") && g.acl != null }
  instance_id = scaleway_rdb_instance.this[each.key].id
  region      = each.value.region
  acl_rules {
    ip          = lookup(each.value, "ip")
    description = lookup(each.value, "description")
  }
}

