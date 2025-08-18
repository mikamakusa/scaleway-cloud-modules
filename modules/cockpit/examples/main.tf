provider "scaleway" {}

module "cockpit" {
  source = "../"
  cockpit = [{
    enable_managed_alerts = true
    contact_points = [{
      email = "alert1@example.com"
      }, {
      email = "alert2@example.com"
    }]
    user = [{
      login = "my-awesome-user"
      role  = "editor"
    }]
    source = [{
      name           = "my-data-source"
      type           = "metrics"
      retention_days = 70
    }]
    token_scopes = [{
      query_logs    = true
      write_logs    = true
      query_metrics = true
      write_metrics = true
      query_traces  = true
      write_traces  = true
    }]
  }]
}