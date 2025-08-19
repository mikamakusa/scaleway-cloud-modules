resource "scaleway_edge_services_pipeline" "this" {
  count       = length(var.pipeline)
  name        = join("-", [lookup(var.pipeline[count.index], "name"), "pipeline"])
  description = lookup(var.pipeline[count.index], "description")
  project_id  = data.scaleway_account_project.this.id
}

resource "scaleway_edge_services_plan" "this" {
  for_each   = { for plan in var.pipeline : plan.name => plan if contains(keys(plan), "plan") && plan.plan == true }
  name       = join("-", [each.value.name, "plan"])
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_edge_services_backend_stage" "this" {
  count       = length(var.pipeline) == "0" ? "0" : length(var.backend_stage)
  pipeline_id = element(scaleway_edge_services_pipeline.this.*.id, lookup(var.backend_stage[count.index], "pipeline_id"))
  project_id  = data.scaleway_account_project.this.id

  dynamic "s3_backend_config" {
    for_each = length(var.bucket) != null ? lookup(var.backend_stage[count.index], "s3_backend_config") : []
    iterator = s3
    content {
      bucket_name   = element(scaleway_object_bucket.this.*.name, lookup(s3.value, "bucket_id"))
      bucket_region = element(scaleway_object_bucket.this.*.region, lookup(s3.value, "bucket_id"))
    }
  }

  dynamic "lb_backend_config" {
    for_each = length(var.lb) != null ? lookup(var.backend_stage[count.index], "lb_backend_config") : []
    iterator = lb
    content {
      lb_config {
        id          = element(scaleway_lb.this.*.id, lookup(lb.value, "lb_id"))
        is_ssl      = lookup(lb.value, "is_ssl")
        domain_name = lookup(lb.value, "domain_name")
        frontend_id = element(scaleway_lb_frontend.this.*.id, lookup(lb.value, "frontend_id"))
        zone        = lookup(lb.value, "zone")
      }
    }
  }
}

resource "scaleway_edge_services_cache_stage" "this" {
  count            = length(var.pipeline) == "0" ? "0" : length(var.cache_stage)
  pipeline_id      = element(scaleway_edge_services_pipeline.this.*.id, lookup(var.cache_stage[count.index], "pipeline_id"))
  backend_stage_id = element(scaleway_edge_services_backend_stage.this.*.id, lookup(var.cache_stage[count.index], "backend_stage_id"))
  route_stage_id   = element(scaleway_edge_services_route_stage.this.*.id, lookup(var.cache_stage[count.index], "route_stage_id"))
  waf_stage_id     = element(scaleway_edge_services_waf_stage.this.*.id, lookup(var.cache_stage[count.index], "waf_stage_id"))
  fallback_ttl     = lookup(var.cache_stage[count.index], "fallback_ttl")
  refresh_cache    = lookup(var.cache_stage[count.index], "refresh_cache")
  project_id       = data.scaleway_account_project.this.id

  dynamic "purge_requests" {
    for_each = lookup(var.cache_stage[count.index], "purge_request") == null ? [] : [""]
    iterator = purge
    content {
      pipeline_id = element(scaleway_edge_services_pipeline.this.*.id, lookup(purge.value, "pipeline_id"))
      assets      = lookup(purge.value, "assets")
      all         = lookup(purge.value, "all")
    }
  }
}

resource "scaleway_edge_services_dns_stage" "this" {
  count            = length(var.pipeline) == "0" ? "0" : length(var.dns_stage)
  pipeline_id      = element(scaleway_edge_services_pipeline.this.*.id, lookup(var.dns_stage[count.index], "pipeline_id"))
  backend_stage_id = element(scaleway_edge_services_backend_stage.this.*.id, lookup(var.dns_stage[count.index], "backend_stage_id"))
  tls_stage_id     = element(scaleway_edge_services_tls_stage.this.*.id, lookup(var.dns_stage[count.index], "tls_stage_id"))
  cache_stage_id   = element(scaleway_edge_services_cache_stage.this.*.id, lookup(var.dns_stage[count.index], "cache_stage_id"))
  fqdns            = lookup(var.dns_stage[count.index], "fqdns")
  project_id       = data.scaleway_account_project.this.id
}

resource "scaleway_edge_services_head_stage" "this" {
  count         = length(var.pipeline) == "0" ? "0" : length(var.head_stage)
  pipeline_id   = element(scaleway_edge_services_pipeline.this.*.id, lookup(var.head_stage[count.index], "pipeline_id"))
  head_stage_id = element(scaleway_edge_services_dns_stage.this.*.id, lookup(var.head_stage[count.index], "head_stage_id"))
}

resource "scaleway_edge_services_route_stage" "this" {
  count        = length(var.pipeline) == "0" ? "0" : length(var.route_stage)
  pipeline_id  = element(scaleway_edge_services_pipeline.this.*.id, lookup(var.route_stage[count.index], "pipeline_id"))
  waf_stage_id = element(scaleway_edge_services_waf_stage.this.*.id, lookup(var.route_stage[count.index], "waf_stage_id"))
  project_id   = data.scaleway_account_project.this.id

  dynamic "rule" {
    for_each = length(var.backend_stage) != null ? lookup(var.route_stage[count.index], "rule") : []
    content {
      backend_stage_id = element(scaleway_edge_services_backend_stage.this.*.id, lookup(rule.value, "backend_stage_id"))
      rule_http_match {
        method_filters = lookup(rule.value, "method_filters")

        dynamic "path_filter" {
          for_each = lookup(rule.value, "path_filter") == null ? [] : [""]
          iterator = path
          content {
            path_filter_type = lookup(path.value, "path_filter_type")
            value            = lookup(path.value, "value")
          }
        }
      }
    }
  }
}

resource "scaleway_edge_services_tls_stage" "this" {
  count               = length(var.pipeline) == "0" ? "0" : length(var.tls_stage)
  pipeline_id         = element(scaleway_edge_services_pipeline.this.*.id, lookup(var.tls_stage[count.index], "pipeline_id"))
  backend_stage_id    = element(scaleway_edge_services_backend_stage.this.*.id, lookup(var.tls_stage[count.index], "backend_stage_id"))
  cache_stage_id      = element(scaleway_edge_services_cache_stage.this.*.id, lookup(var.tls_stage[count.index], "cache_stage_id"))
  route_stage_id      = element(scaleway_edge_services_route_stage.this.*.id, lookup(var.tls_stage[count.index], "route_stage_id"))
  waf_stage_id        = element(scaleway_edge_services_waf_stage.this.*.id, lookup(var.tls_stage[count.index], "waf_stage_id"))
  managed_certificate = lookup(var.tls_stage[count.index], "managed_certificate")
  project_id          = data.scaleway_account_project.this.id
}

resource "scaleway_edge_services_waf_stage" "this" {
  count            = length(var.pipeline) == "0" ? "0" : length(var.waf_stage)
  paranoia_level   = lookup(var.waf_stage[count.index], "paranoia_level")
  pipeline_id      = element(scaleway_edge_services_pipeline.this.*.id, lookup(var.waf_stage[count.index], "pipeline_id"))
  backend_stage_id = element(scaleway_edge_services_backend_stage.this.*.id, lookup(var.waf_stage[count.index], "backend_stage_id"))
  mode             = lookup(var.waf_stage[count.index], "mode")
  project_id       = data.scaleway_account_project.this.id
}