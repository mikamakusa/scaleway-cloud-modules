output "load_balancers" {
  description = "Informations sur les load balancers créés."
  value = {
    for k, lb in scaleway_lb.this :
    k => {
      id    = lb.id
      name  = lb.name
      ip_id = lb.ip_id
      type  = lb.type
      tags  = lb.tags
    }
  }
}

output "frontends" {
  description = "Informations sur les frontends créés."
  value = {
    for k, f in scaleway_lb_frontend.this :
    k => {
      id           = f.id
      name         = f.name
      lb_id        = f.lb_id
      inbound_port = f.inbound_port
      backend_id   = f.backend_id
    }
  }
}

output "backends" {
  description = "Informations sur les backends créés."
  value = {
    for k, b in scaleway_lb_backend.this :
    k => {
      id               = b.id
      name             = b.name
      lb_id            = b.lb_id
      forward_protocol = b.forward_protocol
      forward_port     = b.forward_port
      server_ips       = b.server_ips
    }
  }
}

output "ips" {
  description = "IPs réservées pour les load balancers."
  value       = scaleway_lb_ip.this[*].ip_address
}

output "certificates" {
  description = "Informations relatives au(x) certificat(s) lié(s) au Load Balancer."
  value = {
    for f, g in scaleway_lb_certificate.this : f => {
      id                       = g.id
      common_name              = g.common_name
      subject_alternative_name = g.subject_alternative_name
      fingerprint              = g.fingerprint
      not_valid_before         = g.not_valid_before
      not_valid_after          = g.not_valid_after
      status                   = g.status
    }
  }
}

output "routes" {
  description = "Informations relatives au(x) routes entre le backend et le frontend au sein du Load Balancer."
  value = {
    for n, m in scaleway_lb_route.this : n => {
      id         = m.id
      created_at = m.created_at
      updated_at = m.updated_at
    }
  }
}