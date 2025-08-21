module "cluster" {
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
  }]
  autoscaler_config = {
    disable_scale_down              = false
    scale_down_delay_after_add      = "5m"
    estimator                       = "binpacking"
    expander                        = "random"
    balance_similar_node_groups     = true
    expendable_pods_priority_cutoff = -5
  }
}
