terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = ">= 2.48.0"
    }
  }
}

provider "scaleway" {}

resource "scaleway_vpc_private_network" "pn01" {
  name   = "my_private_network"
  region = "fr-par"
}

module "instance" {
  source = "../.."
  instance = [
    {
      name              = "test-mongodb-basic1"
      version           = "7.0.12"
      node_type         = "MGDB-PLAY2-NANO"
      node_number       = 1
      user_name         = "my_initial_user"
      password          = "thiZ_is_v&ry_s3cret"
      volume_size_in_gb = 5
    },
    {
      name               = "test-mongodb-basic2"
      version            = "7.0.12"
      node_type          = "MGDB-PLAY2-NANO"
      node_number        = 3
      user_name          = "my_initial_user_2"
      password           = "thiZ_is_v&ry_s3cret"
      volume_size_in_gb  = 10
      private_network_id = scaleway_vpc_private_network.pn01.id
    }
  ]
}