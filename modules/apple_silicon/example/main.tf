provider "scaleway" {}

module "apple" {
  source = "../"
  vpcs = [
    {
      name = "vpc-apple-silicon"
      private_network = [
        {
          name = "pn-apple-silicon"
        }
      ]
    }
  ]
  ipv4_subnet = "192.168.0.0/24"
  apple_silicon_servers = [
    {
      name       = "TestAccServerEnableVPC"
      type       = "M2-M"
      enable_vpc = true
    }
  ]
}