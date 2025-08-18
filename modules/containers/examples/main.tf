provider "scaleway" {}

module "containers" {
  source = "../"
  namespaces = [{
    name = "namespace-1"
    environment_variables = {
      "foo" = "var"
    }
    secret_environment_variables = {
      "key" = "secret"
    }
    containers = [{
      name           = "my-container-01"
      tags           = ["tag1", "tag2"]
      registry_image = "alpine:test"
      port           = 9997
      cpu_limit      = 140
      memory_limit   = 256
      min_scale      = 3
      max_scale      = 5
      timeout        = 600
      cron = [{
        schedule = "5 4 1 * *"
        args = jsonencode(
          {
            address = {
              city    = "Paris"
              country = "FR"
            }
          }
        )
      }]
    }]
  }]
  tokens = [{
    namespace_name = "namespace-1"
    expires_at     = "2022-10-18T11:35:15+02:00"
  }]
}