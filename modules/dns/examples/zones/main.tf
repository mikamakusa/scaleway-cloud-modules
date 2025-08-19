provider "scaleway" {}

module "zones" {
  source = "../../"
  zones = [{
    domain    = "scaleway-terraform.com"
    subdomain = "test"
  }]
}