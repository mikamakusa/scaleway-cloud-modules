provider "scaleway" {}

module "backend_stage_bucket" {
  source = "../../"
  bucket = [{
    id   = "9"
    name = "bucket-1"
  }]
  pipeline = [{
    id   = "5"
    name = "pipe-1"
  }]
  backend_stage = [{
    id          = "1"
    pipeline_id = "5"
    s3_backend_config = [{
      bucket_id = "9"
    }]
  }]
  waf_stage = [{
    id               = "10"
    pipeline_id      = "5"
    mode             = "enable"
    backend_stage_id = "1"
  }]
}