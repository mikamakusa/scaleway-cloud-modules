resource "scaleway_registry_namespace" "this" {
  for_each    = var.registry_namespace
  name        = each.key
  description = each.value.description
  is_public   = each.value.is_public
  region      = each.value.region
  project_id  = data.scaleway_account_project.this.id
}