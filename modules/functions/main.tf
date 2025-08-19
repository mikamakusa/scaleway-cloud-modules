resource "scaleway_function_namespace" "this" {
  for_each                     = { for a in var.function : a.namespace_name != null ? a.name : null => a if a.namespace_name != null }
  name                         = join("-", [each.value.name, "namespace"])
  description                  = each.value.description
  tags                         = concat(var.tags, each.value.tags)
  region                       = each.value.region
  project_id                   = data.scaleway_account_project.this.project_id
  environment_variables        = each.value.environment_variables
  secret_environment_variables = each.value.secret_environment_variables
  activate_vpc_integration     = each.value.activate_vpc_integration
}

resource "scaleway_function" "this" {
  for_each                     = { for b in var.function : b.name => b }
  handler                      = each.value.handler
  namespace_id                 = scaleway_function_namespace.this[join("-", [each.value.name, "namespace"])].id
  privacy                      = each.value.privacy
  runtime                      = each.value.runtime
  name                         = join("-", [each.value.name, "function"])
  description                  = each.value.description
  region                       = each.value.region
  project_id                   = data.scaleway_account_project.this.project_id
  environment_variables        = each.value.environment_variables
  secret_environment_variables = each.value.secret_environment_variables
  min_scale                    = each.value.min_scale
  max_scale                    = each.value.max_scale
  memory_limit                 = each.value.memory_limit
  zip_file                     = join("/", [path.cwd, "functions", each.value.zip_file])
  zip_hash                     = filesha256(join("/", [path.cwd, "functions", each.value.zip_file]))
  deploy                       = each.value.deploy
  http_option                  = each.value.http_option
  sandbox                      = each.value.sandbox
}

resource "scaleway_function_cron" "this" {
  for_each    = { for c in var.function : c.schedule != null ? c.name : null => c if c.schedule != null }
  args        = each.value.args
  function_id = scaleway_function.this[join("-", [each.value.name, "function"])].id
  schedule    = each.value.schedule
  name        = join("-", [each.value.name, "cron"])
  region      = each.value.region
}

resource "scaleway_function_domain" "this" {
  for_each    = { for d in var.function : d.hostname != null ? d.hostname : null => d if d.hostname != null }
  function_id = scaleway_function.this[join("-", [each.value.name, "function"])].id
  hostname    = each.value.hostname
}

resource "scaleway_function_token" "this" {
  for_each     = { for e in var.function : e.expires_at != null ? e.expires_at : null => e if e.expires_at != null }
  namespace_id = scaleway_function_namespace.this[join("-", [each.value.name, "namespace"])].id
  function_id  = scaleway_function.this[join("-", [each.value.name, "function"])].id
  description  = each.value.description
  expires_at   = each.value.expires_at
  region       = each.value.region
}