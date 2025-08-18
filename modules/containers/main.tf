resource "scaleway_container_namespace" "this" {
  for_each                     = { for namespace in var.namespaces : namespace.name => namespace }
  name                         = each.value.name
  description                  = each.value.description
  tags                         = each.value.tags
  region                       = each.value.region
  environment_variables        = each.value.environment_variables
  secret_environment_variables = each.value.secret_environment_variables
  activate_vpc_integration     = each.value.activate_vpc_integration
  project_id                   = data.scaleway_account_project.this.id
}

resource "scaleway_container" "this" {
  for_each                     = { for namespace in var.namespaces : namespace.name => namespace if contains(keys(namespace), "containers") && namespace.containers != null }
  namespace_id                 = scaleway_container_namespace.this[each.key].id
  name                         = lookup(each.value, "name")
  description                  = lookup(each.value, "description")
  environment_variables        = each.value.environment_variables
  secret_environment_variables = each.value.secret_environment_variables
  min_scale                    = lookup(each.value, "min_scale")
  max_scale                    = lookup(each.value, "max_scale")
  memory_limit                 = lookup(each.value, "memory_limit")
  cpu_limit                    = lookup(each.value, "cpu_limit")
  timeout                      = lookup(each.value, "timeout")
  privacy                      = lookup(each.value, "privacy")
  registry_image               = join("/", [scaleway_container_namespace.this[each.value].registry_endpoint, lookup(each.value, "registry_image")])
  registry_sha256              = lookup(each.value, "registry_sha256")
  protocol                     = lookup(each.value, "protocol")
  http_option                  = lookup(each.value, "http_option")
  sandbox                      = lookup(each.value, "sandbox")
  port                         = lookup(each.value, "port")
  deploy                       = lookup(each.value, "deploy")
  local_storage_limit          = lookup(each.value, "local_storage_limit")
  command                      = lookup(each.value, "command")
  args                         = lookup(each.value, "args")

  dynamic "health_check" {
    for_each = var.health_check != null ? [""] : []
    content {
      failure_threshold = var.health_check.failure_threshold
      interval          = var.health_check.interval

      http {
        path = var.health_check.http_path
      }
    }
  }

  dynamic "scaling_option" {
    for_each = var.scaling_option != null ? [""] : []
    content {
      concurrent_requests_threshold = var.scaling_option.concurrent_requests_threshold
      cpu_usage_threshold           = var.scaling_option.cpu_usage_threshold
      memory_usage_threshold        = var.scaling_option.memory_usage_threshold
    }
  }
}

resource "scaleway_container_cron" "this" {
  for_each     = { for namespace in var.namespaces.*.containers : namespace.name => namespace if contains(keys(namespace), "cron") && namespace.cron != null }
  args         = lookup(each.value, "args")
  container_id = scaleway_container.this[each.key].id
  schedule     = lookup(each.value, "schedule")
  name         = lookup(each.value, "name")
}

resource "scaleway_container_domain" "this" {
  for_each     = { for namespace in var.namespaces.*.containers : namespace.name => namespace if contains(keys(namespace), "domain") && namespace.domain != null }
  container_id = scaleway_container.this[each.key].id
  hostname     = lookup(each.value, "hostname")
  region       = each.value.region
}

resource "scaleway_container_token" "this" {
  for_each     = { for token in var.tokens : token.container_name => token }
  namespace_id = scaleway_container_namespace.this[each.value.namespace_name].id
  container_id = scaleway_container.this[each.value.container_name].id
  description  = each.value.description
  expires_at   = each.value.expires_at
  region       = each.value.region
}

resource "scaleway_container_trigger" "this" {
  for_each     = { for namespace in var.namespaces.*.containers : namespace.name => namespace if contains(keys(namespace), "trigger") && namespace.trigger != null }
  container_id = scaleway_container.this[each.key].id
  name         = lookup(each.value, "name")
  description  = lookup(each.value, "description")
  region       = lookup(each.value, "region")
}