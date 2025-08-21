resource "scaleway_lb_ip" "this" {
  for_each = { for b in var.lb : b.name => b if contains(keys(b), "ip") && length(b.ip) > 0 }
  tags = concat(
    var.tags,
    each.value.tags
  )
  is_ipv6    = each.value.is_ipv6
  reverse    = each.value.reverse
  project_id = data.scaleway_account_project.this.project_id
}

resource "scaleway_lb" "this" {
  for_each                = { for a in var.lb : a.type => a }
  type                    = each.value.type
  assign_flexible_ip      = each.value.assign_flexible_ip
  assign_flexible_ipv6    = each.value.assign_flexible_ipv6
  description             = each.value.description
  ip_ids                  = [lookup(each.value, "ip_id")]
  name                    = join("-", [each.value.name, "lb"])
  project_id              = data.scaleway_account_project.this.project_id
  ssl_compatibility_level = each.value.ssl_compatibility_level
  tags = concat(
    var.tags,
    each.value.tags
  )
}

resource "scaleway_lb_backend" "this" {
  for_each                    = { for c in local.backends : "${c.lb_name}.${c.idx}" => c }
  forward_port                = each.value.backend.forward_port
  forward_protocol            = each.value.backend.forward_protocol
  lb_id                       = scaleway_lb.this[each.value.lb_name].id
  name                        = each.value.backend.name
  server_ips                  = each.value.backend.server_ips
  sticky_sessions             = each.value.backend.sticky_sessions
  sticky_sessions_cookie_name = each.value.backend.sticky_sessions_cookie_name
  proxy_protocol              = each.value.backend.proxy_protocol
  timeout_connect             = each.value.backend.timeout_connect
  timeout_queue               = each.value.backend.timeout_queue
  timeout_server              = each.value.backend.timeout_server
  timeout_tunnel              = each.value.backend.timeout_tunnel
  failover_host               = each.value.backend.failover_host
  forward_port_algorithm      = each.value.backend.forward_port_algorithm
  ssl_bridging                = each.value.backend.ssl_bridging
  ignore_ssl_server_verify    = each.value.backend.ignore_ssl_server_verify
  max_connections             = each.value.backend.max_connections
  max_retries                 = each.value.backend.max_retries
  redispatch_attempt_count    = each.value.backend.redispatch_attempt_count
}

resource "scaleway_lb_frontend" "this" {
  for_each              = { for d in local.frontends : "${d.lb_name}.${d.idx}" => d }
  backend_id            = scaleway_lb_backend.this["${each.value.lb_name}.0"].id
  inbound_port          = each.value.frontend.inbound_port
  lb_id                 = scaleway_lb.this[each.value.lb_name].id
  name                  = each.value.frontend.name
  timeout_client        = each.value.frontend.timeout_client
  certificate_ids       = [scaleway_lb_certificate.this[each.value.lb_name].id]
  enable_http3          = each.value.frontend.enable_http3
  connection_rate_limit = each.value.frontend.connection_rate_limit
}

resource "scaleway_lb_acl" "this" {
  for_each    = { for e in local.acls : "${e.lb_name}.${e.idx}" => e }
  frontend_id = scaleway_lb_frontend.this[each.value.lb_name].id
  index       = each.value.acl.index
  name        = each.value.acl.name
  description = each.value.acl.description
  dynamic "action" {
    for_each = lookup(each.value.acl, "action", [])
    content {
      type = lookup(action.value, "type")
      dynamic "redirect" {
        for_each = lookup(action.value, "redirect", [])
        content {
          type   = lookup(redirect.value, "type")
          target = lookup(redirect.value, "target")
          code   = lookup(redirect.value, "code")
        }
      }
    }
  }
  dynamic "match" {
    for_each = lookup(each.value.acl, "match", [])
    content {
      ip_subnet          = lookup(match.value, "ip_subnet")
      http_filter        = lookup(match.value, "http_filter")
      http_filter_option = lookup(match.value, "http_filter_option")
      http_filter_value  = lookup(match.value, "http_filter_value")
    }
  }
}

resource "scaleway_lb_certificate" "this" {
  for_each = { for f in local.certificates : "${f.lb_name}.${f.idx}" => f }
  lb_id    = scaleway_lb.this[each.value.lb_name].id
  name     = each.value.certificate.name
  dynamic "letsencrypt" {
    for_each = lookup(each.value.certificate, "letsencrypt", [])
    content {
      common_name              = lookup(letsencrypt.value, "common_name")
      subject_alternative_name = lookup(letsencrypt.value, "subject_alternative_name")
    }
  }
  dynamic "custom_certificate" {
    for_each = lookup(each.value.certificate, "custom_certificate", [])
    content {
      certificate_chain = lookup(custom_certificate.value, "certificate_chain")
    }
  }
}

resource "scaleway_lb_route" "this" {
  for_each          = { for g in local.routes : "${g.lb_name}.${g.idx}" => g }
  backend_id        = scaleway_lb_backend.this[each.value.lb_name].id
  frontend_id       = scaleway_lb_frontend.this[each.value.lb_name].id
  match_subdomains  = each.value.route.match_subdomains
  match_sni         = (each.value.route.match_host_header || each.value.route.match_path_begin) != null ? null : each.value.route.match_sni
  match_host_header = (each.value.route.match_sni || each.value.route.match_path_begin) != null ? null : each.value.route.match_host_header
  match_path_begin  = (each.value.route.match_sni || each.value.route.match_host_header) != null ? null : each.value.route.match_path_begin
}