provider "scaleway" {}

variable "application" {
  type = any
}

variable "group" {
  type = any
}

module "group" {
  source      = "../../"
  application = var.application
  group       = var.group
}