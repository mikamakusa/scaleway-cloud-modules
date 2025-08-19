output "functions" {
  value = try(
    {
      for a, z in scaleway_function.this :
      z => {
        id              = z.id
        namespace_id    = z.namespace_id
        domain_name     = z.domain_name
        organization_id = z.organization_id
        cpu_limit       = z.cpu_limit
      }
    }
  )
}

output "cron" {
  value = try(
    {
      for b, y in scaleway_function_cron.this :
      y => {
        id     = y.id
        region = y.region
        status = y.status
      }
    }
  )
}

output "domain" {
  value = try(
    {
      for c, x in scaleway_function_domain.this :
      x => {
        id     = x.id
        region = x.region
        url    = x.url
      }
    }
  )
}

output "namespace" {
  value = try(
    {
      for d, w in scaleway_function_namespace.this :
      w => {
        id                    = w.id
        organization_id       = w.organization_id
        registry_endpoint     = w.registry_endpoint
        registry_namespace_id = w.registry_namespace_id
      }
    }
  )
}

output "token" {
  value = try(
    {
      for e, v in scaleway_function_token.this :
      v => {
        id    = v.id
        token = v.token
      }
    }
  )
}