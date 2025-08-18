## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.59.0 |

## Modules

No modules.

## Usage

- [cockpit](examples/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_cockpit.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/cockpit) | resource |
| [scaleway_cockpit_alert_manager.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/cockpit_alert_manager) | resource |
| [scaleway_cockpit_grafana_user.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/cockpit_grafana_user) | resource |
| [scaleway_cockpit_source.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/cockpit_source) | resource |
| [scaleway_cockpit_token.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/cockpit_token) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cockpit"></a> [cockpit](#input\_cockpit) | n/a | <pre>list(object({<br/>    name                  = string<br/>    region                = string<br/>    enable_managed_alerts = optional(bool)<br/>    contact_points = optional(list(object({<br/>      email = string<br/>    })))<br/>    user = optional(list(object({<br/>      login = string<br/>      role  = string<br/>    })))<br/>    source = optional(list(object({<br/>      retention_days = number<br/>      type           = optional(string)<br/>    })))<br/>    token_scopes = optional(list(object({<br/>      query_logs          = optional(bool)<br/>      write_logs          = optional(bool)<br/>      setup_logs_rules    = optional(bool)<br/>      query_metrics       = optional(bool)<br/>      write_metrics       = optional(bool)<br/>      setup_metrics_rules = optional(bool)<br/>      query_traces        = optional(bool)<br/>      write_traces        = optional(bool)<br/>      setup_alerts        = optional(bool)<br/>    })))<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alert_manager"></a> [alert\_manager](#output\_alert\_manager) | n/a |
| <a name="output_cockpit"></a> [cockpit](#output\_cockpit) | n/a |
| <a name="output_grafana_user"></a> [grafana\_user](#output\_grafana\_user) | n/a |
| <a name="output_source"></a> [source](#output\_source) | n/a |
| <a name="output_token"></a> [token](#output\_token) | n/a |
