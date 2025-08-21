module "acls" {
  source       = "../../"
  project_name = "scl-project-k8s"
  vpc = {
    name = "vpc-1"
  }
  private_network = {
    name = "vpc-pn-1"
  }
  clusters = [{
    name                        = "tf-cluster"
    version                     = "1.32.3"
    cni                         = "cilium"
    delete_additional_resources = false
    acls = [{
      no_ip_allowed = true
    }]
  }]
}

module "acls" {
  source       = "../../"
  project_name = "scl-project-k8s"
  vpc = {
    name = "vpc-1"
  }
  private_network = {
    name = vpc-pn-1
  }
  clusters = [{
    name                        = "tf-cluster"
    version                     = "1.32.3"
    cni                         = "cilium"
    delete_additional_resources = false
  }]
  acl_rules = [{
    ip          = "1.2.3.4/32"
    description = "Allow 1.2.3.4"
    }, {
    scaleway_ranges = true
    description     = "Allow all Scaleway ranges"
  }]
}



