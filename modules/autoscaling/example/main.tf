provider "scaleway" {}

variable "lb_ips" {
  type = any
}

variable "lbs" {
  type = any
}

variable "backends" {
  type = any
}

module "autoscaling" {
  source = "../"
  vpcs = [
    {
      name = "vpc-autoscaling"
      private_network = [
        {
          name = "pn-autoscaling"
        }
      ]
    }
  ]
  ipv4_subnet = "192.168.0.0/24"
  block_volumes = [
    {
      iops       = 5000
      size_in_gb = 10
      snapshots = [
        {
          name = "test-ds-block-snapshot-basic"
        }
      ]
    }
  ]
  lb_ips   = var.lb_ips
  lbs      = var.lbs
  backends = var.backends
  instance_templates = [
    {
      name            = "asg-template"
      commercial_type = "PLAY2-MICRO"
      tags            = ["terraform-test", "basic"]
      instance_groups = [
        {
          name                    = "asg-group"
          tags                    = ["terraform-test", "instance-group"]
          capacity_max_replicas   = 5
          capacity_min_replicas   = 1
          capacity_cooldown_delay = "300"
          lb_name                 = "ipv6-lb"
          private_network_name    = "pn-autoscaling"
        }
      ]
      instance_policies = [
        {
          name                      = "scale-up-if-cpu-high"
          action                    = "scale_up"
          type                      = "flat_count"
          value                     = 1
          priority                  = 1
          metric_name               = "cpu scale up"
          metric_managed_metric     = "managed_metric_instance_cpu"
          metric_operator           = "operator_greater_than"
          metric_aggregate          = "aggregate_average"
          metric_sampling_range_min = 5
          metric_threshold          = 70
        },
        {
          name                      = "scale-down-if-cpu-low"
          action                    = "scale_down"
          type                      = "flat_count"
          value                     = 1
          priority                  = 2
          metric_name               = "cpu scale down"
          metric_managed_metric     = "managed_metric_instance_cpu"
          metric_operator           = "operator_less_than"
          metric_aggregate          = "aggregate_average"
          metric_sampling_range_min = 5
          metric_threshold          = 45
        }
      ]
    }
  ]
  volumes = [
    {
      name        = "as-volume"
      volume_type = "sbs"
      boot        = true
      perf_iops   = 5000
    }
  ]
}

