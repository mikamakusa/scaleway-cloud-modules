output "namespace" {
  value = {
    for a in scaleway_container_namespace.this : a => {
      id                    = a.id
      name                  = a.name
      organization_id       = a.organization_id
      registry_endpoint     = a.registry_endpoint
      registry_namespace_id = a.registry_namespace_id
    }
  }
}

output "container" {
  value = {
    for a in scaleway_container.this : a => {
      id          = a.id
      name        = a.name
      region      = a.region
      status      = a.status
      cron_status = a.cron_status
      domain_name = a.domain_name
    }
  }
}