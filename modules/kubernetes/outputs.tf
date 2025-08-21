## scaleway_k8s_cluster
output "clusters" {
  value = {
    for cluster in scaleway_k8s_cluster.this : cluster => {
      id                     = cluster.id
      name                   = cluster.name
      region                 = cluster.region
      created_at             = cluster.created_at
      updated_at             = cluster.updated_at
      apiserver_url          = cluster.apiserver_url
      wildcard_dns           = cluster.wildcard_dns
      config_file            = cluster.kubeconfig[0].config_file
      host                   = cluster.kubeconfig[0].host
      cluster_ca_certificate = cluster.kubeconfig[0].cluster_ca_certificate
      token                  = cluster.kubeconfig[0].token
      status                 = cluster.status
      upgrade_available      = cluster.upgrade_available
      organization_id        = cluster.organization_id
    }
  }
}

## scaleway_k8s_acl
output "acls" {
  value = {
    for acl in scaleway_k8s_acl.this : acl => {
      id            = acl.id
      region        = acl.region
      no_ip_allowed = acl.no_ip_allowed
      acl_rules_id  = acl.acl_rules.*.id
    }
  }
}

## scaleway_k8s_pool
output "pools" {
  value = {
    for pool in scaleway_k8s_pool.this : pool => {
      id                = pool.id
      region            = pool.region
      name              = pool.name
      status            = pool.status
      size              = pool.size
      min_size          = pool.min_size
      max_size          = pool.max_size
      node_name         = pool.nodes[0].name
      node_public_ip    = pool.nodes[0].public_ip
      node_public_ip_v6 = pool.nodes[0].public_ip_v6
      node_status       = pool.nodes[0].status
    }
  }
}
