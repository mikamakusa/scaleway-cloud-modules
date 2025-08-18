resource "scaleway_cockpit" "this" {
  for_each   = { for cockpit in var.cockpit : cockpit.region => cockpit }
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_cockpit_alert_manager" "this" {
  for_each              = { for cockpit in var.cockpit : cockpit.region => cockpit if contains(keys(cockpit), "contact_points") && cockpit.contact_points != null }
  project_id            = data.scaleway_account_project.this.id
  enable_managed_alerts = each.value.enable_managed_alerts
  region                = each.value.region

  dynamic "contact_points" {
    for_each = { for cockpit in var.cockpit : cockpit.region => cockpit if contains(keys(cockpit), "contact_points") && cockpit.contact_points != null }
    content {
      email = lookup(each.value, "email")
    }
  }
}

resource "scaleway_cockpit_grafana_user" "this" {
  for_each   = { for cockpit in var.cockpit : cockpit.region => cockpit if contains(keys(cockpit), "user") && cockpit.user != null }
  project_id = data.scaleway_account_project.this.id
  login      = lookup(each.value, "login")
  role       = lookup(each.value, "role")
}

resource "scaleway_cockpit_source" "this" {
  for_each       = { for cockpit in var.cockpit : cockpit.region => cockpit if contains(keys(cockpit), "source") && cockpit.source != null }
  project_id     = data.scaleway_account_project.this.id
  retention_days = lookup(each.value, "retention_days")
  name           = join("-", [each.value.name, "source"])
  type           = lookup(each.value, "type")
  region         = each.value.region
}

resource "scaleway_cockpit_token" "this" {
  for_each   = { for cockpit in var.cockpit : cockpit.region => cockpit if contains(keys(cockpit), "token_scopes") && cockpit.token_scopes != null }
  project_id = data.scaleway_account_project.this.id
  name       = join("-", [each.value.name, "token"])
  region     = each.value.region

  dynamic "scopes" {
    for_each = { for cockpit in var.cockpit : cockpit.region => cockpit if contains(keys(cockpit), "token_scopes") && cockpit.token_scopes != null }
    content {
      query_logs          = lookup(each.value, "query_logs")
      write_logs          = lookup(each.value, "write_logs")
      setup_logs_rules    = lookup(each.value, "setup_logs_rules")
      query_metrics       = lookup(each.value, "query_metrics")
      write_metrics       = lookup(each.value, "write_metrics")
      setup_metrics_rules = lookup(each.value, "setup_metrics_rules")
      query_traces        = lookup(each.value, "query_traces")
      write_traces        = lookup(each.value, "write_traces")
      setup_alerts        = lookup(each.value, "setup_alerts")
    }
  }
}