resource "scaleway_vpc" "this" {
  for_each                         = { for vpc in var.vpcs : vpc.name => vpc }
  name                             = each.value.name
  tags                             = each.value.tags
  enable_routing                   = each.value.enable_routing
  enable_custom_routes_propagation = each.value.enable_custom_routes_propagation
  region                           = each.value.region
  project_id                       = data.scaleway_account_project.this.project_id
}

resource "scaleway_vpc_private_network" "this" {
  for_each                         = { for vpc in var.vpcs : vpc.name => vpc if contains(keys(vpc), "private_network") && vpc.private_network != null }
  name                             = lookup(each.value, "name")
  tags                             = lookup(each.value, "tags")
  project_id                       = data.scaleway_account_project.this.project_id
  vpc_id                           = scaleway_vpc.this[each.key].id
  region                           = scaleway_vpc.this[each.key].region
  enable_default_route_propagation = lookup(each.value, "enable_default_route_propagation")

  dynamic "ipv4_subnet" {
    for_each = var.ipv4_subnet != null ? [""] : []
    content {
      subnet = var.ipv4_subnet
    }
  }

  dynamic "ipv6_subnets" {
    for_each = var.ipv6_subnets != null ? [""] : []
    content {
      subnet = var.ipv6_subnets
    }
  }
}

resource "scaleway_block_volume" "this" {
  for_each   = { for volume in var.block_volumes : volume.iops => volume }
  iops       = each.value.iops
  size_in_gb = each.value.size_in_gb
  name       = each.value.name
  tags       = each.value.tags
  zone       = each.value.zone
  project_id = data.scaleway_account_project.this.project_id
}

resource "scaleway_block_snapshot" "this" {
  for_each   = { for volume in var.block_volumes : volume.iops => volume if contains(keys(volume), "snapshots") && volume.snapshots != null }
  name       = lookup(each.value, "name")
  volume_id  = scaleway_block_volume.this[each.key].id
  zone       = lookup(each.value, "zone")
  tags       = lookup(each.value, "tags")
  project_id = data.scaleway_account_project.this.project_id
}

resource "scaleway_lb_ip" "this" {
  count      = length(var.lb_ips)
  zone       = lookup(var.lb_ips[count.index], "zone")
  project_id = data.scaleway_account_project.this.project_id
  reverse    = lookup(var.lb_ips[count.index], "reverse")
  tags       = lookup(var.lb_ips[count.index], "tags")
  is_ipv6    = lookup(var.lb_ips[count.index], "is_ipv6")
}
resource "scaleway_lb" "this" {
  count                   = length(var.lb_ips) == "0" ? "0" : length(var.lbs)
  ip_ids                  = [element(scaleway_lb_ip.this.*.id, lookup(var.lbs[count.index], "ip_ids"))]
  type                    = lookup(var.lbs[count.index], "type")
  assign_flexible_ip      = lookup(var.lbs[count.index], "assign_flexible_ip")
  assign_flexible_ipv6    = lookup(var.lbs[count.index], "assign_flexible_ipv6")
  name                    = lookup(var.lbs[count.index], "name")
  description             = lookup(var.lbs[count.index], "description")
  tags                    = lookup(var.lbs[count.index], "tags")
  ssl_compatibility_level = lookup(var.lbs[count.index], "ssl_compatibility_level")
  zone                    = lookup(var.lbs[count.index], "zone")
  project_id              = data.scaleway_account_project.this.project_id

  dynamic "private_network" {
    for_each = { for vpc in var.vpcs : vpc.name => vpc if contains(keys(vpc), "private_network") && vpc.private_network != null }
    content {
      private_network_id = scaleway_vpc_private_network.this[0].id
    }
  }
}

resource "scaleway_lb_backend" "this" {
  count                        = length(var.lbs) == "0" ? "0" : length(var.backends)
  lb_id                        = element(scaleway_lb.this.*.id, lookup(var.backends[count.index], "lb_id"))
  forward_protocol             = lookup(var.backends[count.index], "forward_protocol")
  forward_port                 = lookup(var.backends[count.index], "forward_port")
  proxy_protocol               = lookup(var.backends[count.index], "proxy_protocol")
  name                         = lookup(var.backends[count.index], "name")
  forward_port_algorithm       = lookup(var.backends[count.index], "forward_port_algorithm")
  failover_host                = lookup(var.backends[count.index], "failover_host")
  health_check_delay           = lookup(var.backends[count.index], "health_check_delay")
  health_check_max_retries     = lookup(var.backends[count.index], "health_check_max_retries")
  health_check_port            = lookup(var.backends[count.index], "health_check_port")
  health_check_send_proxy      = lookup(var.backends[count.index], "health_check_send_proxy")
  health_check_timeout         = lookup(var.backends[count.index], "health_check_timeout")
  health_check_transient_delay = lookup(var.backends[count.index], "health_check_transient_delay")
  ignore_ssl_server_verify     = lookup(var.backends[count.index], "ignore_ssl_server_verify")
  max_connections              = lookup(var.backends[count.index], "max_connections")
  max_retries                  = lookup(var.backends[count.index], "max_retries")
  redispatch_attempt_count     = lookup(var.backends[count.index], "redispatch_attempt_count")
  server_ips                   = lookup(var.backends[count.index], "server_ips")
  ssl_bridging                 = lookup(var.backends[count.index], "ssl_bridging")
  sticky_sessions              = lookup(var.backends[count.index], "sticky_sessions")
  sticky_sessions_cookie_name  = lookup(var.backends[count.index], "sticky_sessions_cookie_name")
  timeout_connect              = lookup(var.backends[count.index], "timeout_connect")
  timeout_server               = lookup(var.backends[count.index], "timeout_server")
  timeout_queue                = lookup(var.backends[count.index], "timeout_queue")
  timeout_tunnel               = lookup(var.backends[count.index], "timeout_tunnel")
  on_marked_down_action        = lookup(var.backends[count.index], "on_marked_down_action")

  dynamic "health_check_http" {
    for_each = lookup(var.backends[count.index], "health_check_http") != null ? [""] : []
    iterator = http
    content {
      uri         = lookup(http.value, "uri")
      method      = lookup(http.value, "method")
      code        = lookup(http.value, "code")
      host_header = lookup(http.value, "host_header")
    }
  }

  dynamic "health_check_https" {
    for_each = lookup(var.backends[count.index], "health_check_https") != null ? [""] : []
    iterator = https
    content {
      uri         = lookup(https.value, "uri")
      method      = lookup(https.value, "method")
      code        = lookup(https.value, "code")
      host_header = lookup(https.value, "host_header")
      sni         = lookup(https.value, "sni")
    }
  }

  dynamic "health_check_tcp" {
    for_each = lookup(var.backends[count.index], "health_check_tcp") != false ? [""] : []
    content {}
  }
}

resource "scaleway_autoscaling_instance_template" "this" {
  for_each            = { for template in var.instance_templates : template.commercial_type => template }
  commercial_type     = each.value.commercial_type
  tags                = each.value.tags
  name                = each.value.name
  image_id            = each.value.image_id
  security_group_id   = each.value.security_group_id
  placement_group_id  = each.value.placement_group_id
  public_ips_v4_count = each.value.public_ips_v4_count
  public_ips_v6_count = each.value.public_ips_v6_count
  private_network_ids = [scaleway_vpc_private_network.this[0].id]
  cloud_init          = each.value.cloud_init
  zone                = each.value.zone
  project_id          = data.scaleway_account_project.this.project_id

  dynamic "volumes" {
    for_each = var.volumes
    content {
      name        = var.volumes.name
      perf_iops   = var.volumes.perf_iops
      tags        = var.volumes.tags
      boot        = var.volumes.boot
      volume_type = var.volumes.volume_type
    }
  }
}

resource "scaleway_autoscaling_instance_group" "this" {
  for_each                  = { for template in var.instance_templates : template.commercial_type => template if contains(keys(template), "instance_groups") && template.instance_groups != null }
  name                      = lookup(each.value, "name")
  template_id               = scaleway_autoscaling_instance_template.this[each.key].id
  tags                      = lookup(each.value, "tags")
  delete_servers_on_destroy = lookup(each.value, "delete_servers_on_destroy")
  zone                      = lookup(each.value, "zone")
  project_id                = data.scaleway_account_project.this.project_id

  dynamic "capacity" {
    for_each = { for template in var.instance_templates.*.instance_groups : template.commercial_type => template if contains(keys(template), "max_replicas") || contains(keys(template), "min_replicas") || contains(keys(template), "cooldown_delay") }
    content {
      max_replicas   = lookup(each.value, "max_replicas")
      min_replicas   = lookup(each.value, "min_replicas")
      cooldown_delay = lookup(each.value, "cooldown_delay")
    }
  }

  load_balancer {
    id                 = scaleway_lb.this[lookup(each.value, "lb_name")].id
    backend_ids        = [scaleway_lb_backend.this[scaleway_lb.this[lookup(each.value, "lb_name")].id].id]
    private_network_id = scaleway_vpc_private_network.this[lookup(each.value, "private_network_name")].id
  }
}

resource "scaleway_autoscaling_instance_policy" "this" {
  for_each          = { for template in var.instance_templates : template.commercial_type => template if contains(keys(template), "instance_policies") && template.instance_policies != null }
  instance_group_id = scaleway_autoscaling_instance_group.this[each.key].id
  name              = lookup(each.value, "name")
  action            = lookup(each.value, "action")
  type              = lookup(each.value, "type")
  value             = lookup(each.value, "value")
  priority          = lookup(each.value, "priority")
  zone              = lookup(each.value, "zone")
  project_id        = data.scaleway_account_project.this.project_id

  dynamic "metric" {
    for_each = { for template in var.instance_templates.*.instance_policies : template.commercial_type => template if contains(keys(template), "name") || contains(keys(template), "managed_metric") || contains(keys(template), "operator") || contains(keys(template), "aggregate") || contains(keys(template), "sampling_range_min") || contains(keys(template), "threshold") }
    content {
      name               = lookup(each.value, "name")
      managed_metric     = lookup(each.value, "managed_metric")
      operator           = lookup(each.value, "operator")
      aggregate          = lookup(each.value, "aggregate")
      sampling_range_min = lookup(each.value, "sampling_range_min")
      threshold          = lookup(each.value, "threshold")
    }
  }
}