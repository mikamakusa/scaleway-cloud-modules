data "scaleway_account_project" "this" {
  name = var.project_name
}

data "scaleway_secret" "this" {
  count           = var.secret ? 1 : 0
  name            = var.secret.name
  path            = var.secret.path
  secret_id       = var.secret.secret_id
  organization_id = var.secret.organization_id
  region          = var.secret.region
  project_id      = data.scaleway_account_project.this.id
}