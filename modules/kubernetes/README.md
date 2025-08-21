## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.59.0 |

## Modules

No modules.

## Examples

- [clusters](examples/clusters/main.tf)
```hcl
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
```
- [acls](examples/acls/main.tf)
```hcl
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
```
- [pools](examples/pools/main.tf)
```hcl
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
```

## Resources

| Name | Type |
|------|------|
| [scaleway_k8s_acl.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/k8s_acl) | resource |
| [scaleway_k8s_cluster.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/k8s_cluster) | resource |
| [scaleway_k8s_pool.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/k8s_pool) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc) | data source |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc_private_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_acl_rules"></a> [acl\_rules](#input\_acl\_rules) | n/a | <pre>list(object({<br/>    description     = optional(string)<br/>    ip              = optional(string)<br/>    scaleway_ranges = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_auto_upgrade"></a> [auto\_upgrade](#input\_auto\_upgrade) | n/a | <pre>object({<br/>    enable                        = bool<br/>    maintenance_window_day        = string<br/>    maintenance_window_start_hour = number<br/>  })</pre> | `null` | no |
| <a name="input_autoscaler_config"></a> [autoscaler\_config](#input\_autoscaler\_config) | n/a | <pre>object({<br/>    scale_down_delay_after_add       = optional(string)<br/>    scale_down_unneeded_time         = optional(string)<br/>    estimator                        = optional(string)<br/>    expander                         = optional(string)<br/>    disable_scale_down               = optional(bool)<br/>    ignore_daemonsets_utilization    = optional(bool)<br/>    balance_similar_node_groups      = optional(bool)<br/>    expendable_pods_priority_cutoff  = optional(number)<br/>    max_graceful_termination_sec     = optional(number)<br/>    scale_down_utilization_threshold = optional(number)<br/>  })</pre> | `null` | no |
| <a name="input_clusters"></a> [clusters](#input\_clusters) | n/a | <pre>list(object({<br/>    cni                         = string<br/>    delete_additional_resources = bool<br/>    name                        = string<br/>    version                     = string<br/>    type                        = optional(string)<br/>    description                 = optional(string)<br/>    tags                        = optional(list(string))<br/>    feature_gates               = optional(list(string))<br/>    admission_plugins           = optional(list(string))<br/>    apiserver_cert_sans         = optional(list(string))<br/>    region                      = optional(string)<br/>    acls = optional(list(object({<br/>      no_ip_allowed = optional(bool)<br/>    })))<br/>    pools = optional(list(object({<br/>      name                   = string<br/>      node_type              = string<br/>      size                   = number<br/>      min_size               = optional(number)<br/>      max_size               = optional(number)<br/>      autohealing            = optional(bool)<br/>      autoscaling            = optional(bool)<br/>      placement_group_id     = optional(string)<br/>      container_runtime      = optional(string)<br/>      kubelet_args           = optional(map(string))<br/>      root_volume_size_in_gb = optional(number)<br/>      root_volume_type       = optional(string)<br/>      zone                   = optional(string)<br/>      wait_for_pool_ready    = optional(bool)<br/>      public_ip_disabled     = optional(bool)<br/>      max_surge              = optional(number)<br/>      max_unavailable        = optional(number)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>object({<br/>    name = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>object({<br/>    name            = optional(string)<br/>    is_default      = optional(bool)<br/>    organization_id = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_acls"></a> [acls](#output\_acls) | # scaleway\_k8s\_acl |
| <a name="output_clusters"></a> [clusters](#output\_clusters) | # scaleway\_k8s\_cluster |
| <a name="output_pools"></a> [pools](#output\_pools) | # scaleway\_k8s\_pool |
