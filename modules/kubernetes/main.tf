resource "scaleway_k8s_cluster" "this" {
  for_each                    = { for cluster in var.clusters : cluster.name => cluster }
  cni                         = each.value.cni
  delete_additional_resources = each.value.delete_additional_resources
  name                        = each.value.name
  version                     = each.value.version
  private_network_id          = data.scaleway_vpc_private_network.this[0].id
  type                        = each.value.type
  description                 = each.value.description
  tags                        = concat(var.tags, each.value.tags)
  feature_gates               = each.value.feature_gates
  admission_plugins           = each.value.admission_plugins
  apiserver_cert_sans         = each.value.apiserver_cert_sans
  region                      = each.value.region
  project_id                  = data.scaleway_account_project.this.id

  dynamic "auto_upgrade" {
    for_each = var.auto_upgrade != null ? [""] : []
    content {
      enable                        = var.auto_upgrade.enable
      maintenance_window_day        = var.auto_upgrade.maintenance_window_day
      maintenance_window_start_hour = var.auto_upgrade.maintenance_window_start_hour
    }
  }

  dynamic "autoscaler_config" {
    for_each = var.autoscaler_config != null ? [""] : []
    content {
      scale_down_delay_after_add       = var.autoscaler_config.scale_down_delay_after_add
      scale_down_unneeded_time         = var.autoscaler_config.scale_down_unneeded_time
      estimator                        = var.autoscaler_config.estimator
      expander                         = var.autoscaler_config.expander
      disable_scale_down               = var.autoscaler_config.disable_scale_down
      ignore_daemonsets_utilization    = var.autoscaler_config.ignore_daemonsets_utilization
      balance_similar_node_groups      = var.autoscaler_config.balance_similar_node_groups
      expendable_pods_priority_cutoff  = var.autoscaler_config.expendable_pods_priority_cutoff
      max_graceful_termination_sec     = var.autoscaler_config.max_graceful_termination_sec
      scale_down_utilization_threshold = var.autoscaler_config.scale_down_utilization_threshold
    }
  }
}

resource "scaleway_k8s_acl" "this" {
  for_each      = { for cluster in var.clusters : cluster.name => cluster if contains(keys(cluster), "acls") && cluster.acls != null || var.acl_rules != null }
  cluster_id    = scaleway_k8s_cluster.this[each.key].id
  no_ip_allowed = lookup(each.value, "no_ip_allowed")
  region        = each.value.region

  dynamic "acl_rules" {
    for_each = var.acl_rules != null ? [""] : []
    content {
      description     = var.acl_rules.description
      ip              = var.acl_rules.ip
      scaleway_ranges = var.acl_rules.scaleway_ranges
    }
  }
}

resource "scaleway_k8s_pool" "this" {
  for_each               = { for cluster in var.clusters : cluster.name => cluster if contains(keys(cluster), "pools") && cluster.pools != null }
  cluster_id             = scaleway_k8s_cluster.this[each.key].id
  name                   = lookup(each.value, "name")
  node_type              = lookup(each.value, "node_type")
  size                   = lookup(each.value, "size")
  region                 = each.value.region
  min_size               = lookup(each.value, "min_size")
  max_size               = lookup(each.value, "max_size")
  autohealing            = lookup(each.value, "autohealing")
  autoscaling            = lookup(each.value, "autoscaling")
  tags                   = concat(var.tags, each.value.tags, lookup(each.value, "tags"))
  placement_group_id     = lookup(each.value, "placement_group_id")
  container_runtime      = lookup(each.value, "container_runtime")
  kubelet_args           = lookup(each.value, "kubelet_args")
  root_volume_size_in_gb = lookup(each.value, "root_volume_size_in_gb")
  root_volume_type       = lookup(each.value, "root_volume_type")
  zone                   = lookup(each.value, "zone")
  wait_for_pool_ready    = lookup(each.value, "wait_for_pool_ready")
  public_ip_disabled     = lookup(each.value, "public_ip_disabled")

  dynamic "upgrade_policy" {
    for_each = lookup(each.value, "max_surge") != null && lookup(each.value, "max_unavailable") != null ? [""] : []
    content {
      max_surge       = lookup(each.value, "max_surge")
      max_unavailable = lookup(each.value, "max_unavailable")
    }
  }
}