output "cockpit" {
  value = {
    for a in scaleway_cockpit.this : a => {
      id = a.id
    }
  }
}
output "alert_manager" {
  value = {
    for a in scaleway_cockpit_alert_manager.this : a => {
      id                    = a.id
      alert_manager_url     = a.alert_manager_url
      enable_managed_alerts = a.enable_managed_alerts
    }
  }
}
output "grafana_user" {
  value = {
    for a in scaleway_cockpit_grafana_user.this : a => {
      id          = a.id
      login       = sensitive(a.login)
      password    = sensitive(a.password)
      grafana_url = a.grafana_url
    }
  }
}
output "source" {
  value = {
    for a in scaleway_cockpit_source.this : a => {
      id           = a.id
      url          = a.url
      ush_url      = a.push_url
      origin       = a.origin
      synchronized = a.synchronized_with_grafana
    }
  }
}
output "token" {
  value = {
    for a in scaleway_cockpit_token.this : a => {
      id         = a.id
      secret_key = a.secret_key
    }
  }
}