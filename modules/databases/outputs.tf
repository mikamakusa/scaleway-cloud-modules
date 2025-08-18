## scaleway_rdb_instance
output "instance" {
  description = "Informations sur les instances de bases de données créées."
  value = {
    for a, b in scaleway_rdb_instance.this : a => {
      id            = a.id
      name          = a.name
      engine        = a.engine
      endpoint_ip   = a.endpoint_ip
      endpoint_port = a.endpoint_port
      user_name     = a.user_name
      password      = a.password
      certificate   = a.certificate
      is_ha_cluster = a.is_ha_cluster
    }
  }
}

## scaleway_rdb_database
output "database" {
  description = "Informations sur les bases de données créées."
  value = {
    for c, d in scaleway_rdb_database.this : c => {
      id      = c.id
      owner   = c.owner
      managed = c.managed
      size    = c.size
    }
  }
}

## scaleway_rdb_database_backup
output "database_backup" {
  description = "Informations sur les backup des bases de données créées."
  value = {
    for e, f in scaleway_rdb_database_backup.this : e => {
      id            = e.id
      size          = e.size
      instance_name = e.instance_name
      instance_id   = e.instance_id
      created_at    = e.created_at
      updated_at    = e.updated_at
    }
  }
}

## scaleway_rdb_privilege
output "privilege" {
  description = "Informations sur les permissions accordées aux utilisateurs sur les bases de données."
  value = {
    for g, h in scaleway_rdb_privilege.this : g => {
      id = g.id
    }
  }
}

## scaleway_rdb_read_replica
output "read_replica" {
  description = "Informations sur les read replicas."
  value = {
    for i, j in scaleway_rdb_read_replica.this : i => {
      id            = i.id
      direct_access = i.direct_access
    }
  }
}

## scaleway_rdb_user
output "user" {
  description = "Informations sur les utilisateurs."
  value = {
    for k, l in scaleway_rdb_user.this : k => {
      id = k.id
    }
  }
}
