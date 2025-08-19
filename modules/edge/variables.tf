## TAGS
variable "tags" {
  type    = map(string)
  default = {}
}

## AUTRES
variable "bucket" {
  type = list(object({
    id   = string
    name = string
    tags = optional(map(string))
  }))
}

variable "lb" {
  type = list(object({
    id   = string
    type = string
  }))
  default = []
}

variable "lb_frontend" {
  type = list(object({
    id           = string
    backend_id   = string
    inbound_port = number
    lb_id        = string
  }))
  default = []
}

variable "lb_backend" {
  type = list(object({
    id               = string
    forward_port     = number
    forward_protocol = string
    lb_id            = string
  }))
  default = []
}

## EDGE
variable "pipeline" {
  type = list(object({
    id          = string
    name        = optional(string)
    description = optional(string)
    plan        = bool
  }))
  default = []
}

variable "backend_stage" {
  type = list(object({
    id            = string
    pipeline_id   = string
    s3_backend_config = optional(list(object({
      bucket_id = string
    })))
    lb_backend_config = optional(list(object({
      lb_id       = optional(string)
      is_ssl      = optional(bool)
      domain_name = optional(string)
      frontend_id = optional(string)
      zone        = optional(string)
    })))
  }))
  default = []
}

variable "cache_stage" {
  type = list(object({
    id               = string
    pipeline_id      = string
    backend_stage_id = optional(string)
    route_stage_id   = optional(string)
    waf_stage_id     = optional(string)
    fallback_ttl     = optional(number)
    refresh_cache    = optional(string)
    purge_request = optional(list(object({
      pipeline_id = optional(string)
      assets      = optional(list(string))
      all         = optional(bool)
    })))
  }))
  default = []
}

variable "dns_stage" {
  type = list(object({
    id               = string
    pipeline_id      = string
    backend_stage_id = optional(string)
    tls_stage_id     = optional(string)
    cache_stage_id   = optional(string)
    fqdns            = optional(list(string))
  }))
  default = []
}

variable "head_stage" {
  type = list(object({
    id            = string
    pipeline_id   = string
    head_stage_id = optional(string)
  }))
  default = []
}

variable "route_stage" {
  type = list(object({
    id           = string
    pipeline_id  = string
    waf_stage_id = optional(string)
    rule = optional(list(object({
      backend_stage_id = string
      method_filters = optional(list(string))
      path_filter = optional(list(object({
        path_filter_type = string
        value            = string
      })))
    })))
  }))
  default = []
}

variable "tls_stage" {
  type = list(object({
    id                  = string
    pipeline_id         = string
    backend_stage_id    = optional(string)
    cache_stage_id      = optional(string)
    route_stage_id      = optional(string)
    waf_stage_id        = optional(string)
    managed_certificate = optional(bool)
  }))
  default = []
}

variable "waf_stage" {
  type = list(object({
    id               = string
    paranoia_level   = number
    pipeline_id      = string
    backend_stage_id = optional(string)
    mode             = optional(string)
  }))
  default = []
}