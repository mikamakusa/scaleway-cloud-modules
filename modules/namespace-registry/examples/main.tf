provider "scaleway" {}

module "namespace-registry" {
  source = "../"
  registry_namespace = {
    main-cr = {
      description = "Main container registry"
      is_public   = false
    }
  }
}