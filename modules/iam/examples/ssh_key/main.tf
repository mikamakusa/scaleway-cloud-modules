provider "scaleway" {}

variable "ssh_key" {
  type = any
}

module "ssh_key" {
  source  = "../../"
  ssh_key = var.ssh_key
}