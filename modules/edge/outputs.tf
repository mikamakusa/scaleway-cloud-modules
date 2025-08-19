output "pipeline" {
  value = {
    for a in scaleway_edge_services_pipeline.this : a => {
      id     = a.id
      status = a.status
    }
  }
}
output "plan" {
  value = {
    for a in scaleway_edge_services_plan.this : a => {
      id = a.id
    }
  }
}
output "backend_stage" {
  value = {
    for a in scaleway_edge_services_backend_stage.this : a => {
      id = a.id
    }
  }
}
output "cache_stage" {
  value = {
    for a in scaleway_edge_services_cache_stage.this : a => {
      id = a.id
    }
  }
}
output "dns_stage" {
  value = {
    for a in scaleway_edge_services_dns_stage.this : a => {
      id   = a.id
      type = a.type
    }
  }
}
output "head_stage" {
  value = {
    for a in scaleway_edge_services_head_stage.this : a => {
      id = a.id
    }
  }
}
output "route_stage" {
  value = {
    for a in scaleway_edge_services_route_stage.this : a => {
      id = a.id
    }
  }
}
output "tls_stage" {
  value = {
    for a in scaleway_edge_services_tls_stage.this : a => {
      id                     = a.id
      certificate_expires_at = a.certificate_expires_at
    }
  }
}
output "waf_stage" {
  value = {
    for a in scaleway_edge_services_waf_stage.this : a => {
      id = a.id
    }
  }
}