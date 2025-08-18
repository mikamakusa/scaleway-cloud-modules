## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.57.0 |

## Modules

No modules.

## Usage

- [database](examples/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_rdb_acl.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/rdb_acl) | resource |
| [scaleway_rdb_database.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/rdb_database) | resource |
| [scaleway_rdb_database_backup.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/rdb_database_backup) | resource |
| [scaleway_rdb_instance.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/rdb_instance) | resource |
| [scaleway_rdb_privilege.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/rdb_privilege) | resource |
| [scaleway_rdb_read_replica.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/rdb_read_replica) | resource |
| [scaleway_rdb_user.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/rdb_user) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_instance"></a> [instance](#input\_instance) | n/a | <pre>list(object({<br/>    engine                    = string<br/>    node_type                 = string<br/>    volume_type               = optional(string)<br/>    volume_size_in_gb         = optional(number)<br/>    user_name                 = optional(string)<br/>    password                  = optional(string)<br/>    is_ha_cluster             = optional(bool)<br/>    name                      = optional(string)<br/>    tags                      = optional(list(string))<br/>    region                    = optional(string)<br/>    project_id                = optional(string)<br/>    encryption_at_rest        = optional(bool)<br/>    backup_same_region        = optional(bool)<br/>    backup_schedule_frequency = optional(number)<br/>    backup_schedule_retention = optional(number)<br/>    disable_backup            = optional(bool)<br/>    settings                  = optional(map(string))<br/>    init_settings             = optional(map(string))<br/>    database_backup = optional(list(object({<br/>      database_name = string<br/>      instance_id   = string<br/>      expires_at    = optional(string)<br/>    })))<br/>    privilege = optional(list(object({<br/>      permission = string<br/>      user_name  = string<br/>    })))<br/>    read_replica = optional(list(object({<br/>      same_zone     = optional(bool)<br/>    })))<br/>    user = optional(list(object({<br/>      name     = string<br/>      password = string<br/>      is_admin = optional(string)<br/>    })))<br/>    acl = optional(list(object({<br/>      ip          = string<br/>      description = optional(string)<br/>    })))<br/>  }))</pre> | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_database"></a> [database](#output\_database) | Informations sur les bases de données créées. |
| <a name="output_database_backup"></a> [database\_backup](#output\_database\_backup) | Informations sur les backup des bases de données créées. |
| <a name="output_instance"></a> [instance](#output\_instance) | Informations sur les instances de bases de données créées. |
| <a name="output_privilege"></a> [privilege](#output\_privilege) | Informations sur les permissions accordées aux utilisateurs sur les bases de données. |
| <a name="output_read_replica"></a> [read\_replica](#output\_read\_replica) | Informations sur les read replicas. |
| <a name="output_user"></a> [user](#output\_user) | Informations sur les utilisateurs. |
