provider "scaleway" {}

module "block" {
  source = "../"
  buckets = [{
    name = "snapshot-bucket"
    objects = [{
      key  = "my-snapshot.qcow2"
      file = "imported-snapshot/snapshot.qcow2"
    }]
  }]
  lifecycle_rule = [{
    id              = "id1"
    prefix          = "path1/"
    enabled         = true
    storage_class   = "GLACIER"
    transition_days = 10
  }]
  block_volumes = [{
    iops = 5000
    name = "to-export"
    export = [{
      bucket_name = "snapshot-bucket"
      folder      = "imported-snapshot"
      file        = "snapshot.qcow2"
    }]
  }]
}
