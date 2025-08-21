resource "scaleway_job_definition" "this" {
  for_each     = var.job_definitions
  cpu_limit    = each.value.cpu_limit
  memory_limit = each.value.memory_limit
  image_uri    = each.value.image_uri
  name         = each.key
  description  = each.value.description
  command      = each.value.command
  timeout      = each.value.timeout
  env          = each.value.env
  region       = each.value.region
  project_id   = data.scaleway_account_project.this.id

  dynamic "cron" {
    for_each = var.cron != null ? [""] : []
    content {
      schedule = var.cron.schedule
      timezone = var.cron.timezone
    }
  }

  dynamic "secret_reference" {
    for_each = var.secret != null && var.secret_reference != null ? [""] : []
    content {
      secret_id      = data.scaleway_secret.this[0].id
      secret_version = var.secret_reference.secret_version
      file           = var.secret_reference.file
      environment    = var.secret_reference.environment
    }
  }
}