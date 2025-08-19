lb_ips = [
  {
    id      = "9"
    is_ipv6 = true
    zone    = "fr-par-1"
  }
]
lbs = [
  {
    id     = "5"
    ip_ids = "9"
    name   = "ipv6-lb"
    type   = "LB-S"
  }
]
backends = [
  {
    id               = "0"
    lb_id            = "5"
    name             = "backend01"
    forward_protocol = "http"
    forward_port     = "80"
    health_check_http = [
      {
        uri = "/health"
      }
    ]
  }
]