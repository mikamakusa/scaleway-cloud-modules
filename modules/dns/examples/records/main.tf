provider "scaleway" {}

module "records-1" {
  source = "../../"
  records = [{
    dns_zone = "domain.tld"
    name     = "www"
    type     = "A"
    data     = "1.2.3.4"
    ttl      = 3600
  },{
    dns_zone = "domain.tld"
    name     = ""
    type     = "MX"
    data     = "mx-cache.online.net."
    ttl      = 3600
    priority = 20
  }]
}

module "records-2" {
  source = "../../"
  records = [{
    dns_zone = "domain.tld"
    name     = ""
    type     = "MX"
    data     = "mx-cache.online.net."
    ttl      = 3600
    priority = 20
  }]
  weighted = [{
    ip     = "1.2.3.5"
    weight = 1
  }]
  view = [{
    subnet = "100.0.0.0/16"
    data   = "1.2.3.5"
  }]
  http_service = [{
    ips          = ["1.2.3.5", "1.2.3.6"]
    must_contain = "up"
    url          = "http://mywebsite.com/health"
    user_agent   = "scw_service_up"
    strategy     = "hashed"
  }]
}