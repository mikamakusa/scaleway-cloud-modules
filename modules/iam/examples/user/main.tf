provider "scaleway" {}

variable "user" {
  type = any
}

module "user" {
  source  = "../../"
  user = var.user
}