output "registry_namespace" {
  description = "Informations relatives au namespace du registry des conteneurs."
  value = {
    for key, value in scaleway_registry_namespace.this : key => {
      id              = value.id
      endpoint        = value.endpoint
      organization_id = value.organization_id
      name            = value.name
    }
  }
}