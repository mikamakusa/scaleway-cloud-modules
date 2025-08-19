provider "scaleway" {}

variable "application" {
  type = any
}

module "application" {
  source      = "../../"
  application = var.application
}