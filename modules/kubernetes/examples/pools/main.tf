module "pools" {
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
    pools = [{
      name               = "bill"
      node_type          = "DEV1-M"
      size               = 3
      min_size           = 0
      max_size           = 10
      autoscaling        = true
      autohealing        = true
      container_runtime  = "containerd"
      placement_group_id = "1267e3fd-a51c-49ed-ad12-857092ee3a3d"
    }]
  }]
}
