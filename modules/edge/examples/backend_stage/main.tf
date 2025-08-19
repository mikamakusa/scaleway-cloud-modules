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
}

module "backend_stage_lb" {
  source = "../../"
  lb = [{
    id   = "15"
    zone = "fr-par-1"
    type = "LB-S"
  }]
  lb_backend = [{
    id               = "20"
    lb_id            = "15"
    name             = "backend01"
    forward_protocol = "http"
    forward_port     = "80"
  }]
  lb_frontend = [{
    id           = "18"
    lb_id        = "15"
    backend_id   = "30"
    name         = "frontend01"
    inbound_port = "443"
  }]
  pipeline = [{
    id   = "5"
    name = "pipe-1"
  }]
  backend_stage = [{
    id          = "1"
    pipeline_id = "5"
    lb_backend_config = [{
      id          = "15"
      is_ssl      = true
      frontend_id = "18"
    }]
  }]
}