locals {
  backends = flatten([
    for a in var.lb : [
      for idx, backend in(try(a.backend, [])) : {
        lb_name = a.name
        idx     = idx
        backend = backend
      }
    ]
  ])
  frontends = flatten([
    for b in var.lb : [
      for idx, frontend in(try(b.frontend, [])) : {
        lb_name  = b.name
        idx      = idx
        frontend = frontend
      }
    ]
  ])
  acls = flatten([
    for c in var.lb : [
      for idx, acl in(try(c.acl, [])) : {
        lb_name = c.name
        idx     = idx
        acl     = acl
      }
    ]
  ])
  certificates = flatten([
    for d in var.lb : [
      for idx, cert in(try(d.certificate, [])) : {
        lb_name = d.name
        idx     = idx
        cert    = cert
      }
    ]
  ])
  routes = flatten([
    for e in var.lb : [
      for idx, route in(try(e.route, [])) : {
        lb_name = e.name
        idx     = idx
        route   = route
    }]
  ])
}