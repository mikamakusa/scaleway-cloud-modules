provider "scaleway" {}

variable "application" {
  type = any
}

module "policy" {
  source      = "../../"
  application = var.application
  policy = [{
    id             = "9"
    name           = "my policy"
    description    = "gives app readonly access to object storage in project"
    application_id = "0"
    rule = [
      {
        permission_set_names = ["ObjectStorageReadOnly"]
      }
    ]
  }]
}