output "clusters" {
  value = {
    for redis in scaleway_redis_cluster.this : redis => {
      id                          = redis.id
      name                        = redis.name
      password                    = sensitive(redis.password)
      user_name                   = sensitive(redis.user_name)
      certificate                 = sensitive(redis.certificate)
      public_network_id           = redis.public_network[0].id
      public_network_port         = redis.public_network[0].port
      ips                         = redis.public_network[0].ips
      private_network_endpoint_id = redis.private_network[0].endpoint_id
      private_network_zone        = redis.private_network[0].zone
      private_network_port        = redis.private_network[0].port
      private_network_ips         = redis.private_network[0].ips
    }
  }
}