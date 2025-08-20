variable "project_name" {
  type = string
}

variable "hubs" {
  type = list(object({
    name         = string
    product_plan = string
    region       = optional(string)
    devices = optional(list(object({
      name                       = string
      description                = optional(string)
      allow_insecure             = optional(bool)
      allow_multiple_connections = optional(bool)
    })))
    networks = optional(list(object({
      name         = string
      type         = string
      topic_prefix = optional(string)
    })))
    routes = optional(list(object({
      name             = string
      topic            = string
      database_name    = optional(string)
      database_query   = optional(string)
      s3_strategy      = optional(string)
      s3_object_prefix = optional(string)
    })))
  }))
}

variable "instance" {
  type    = any
  default = []
}

variable "s3_bucket_name" {
  type    = string
  default = null
}

variable "rest" {
  type = object({
    headers = map(string)
    uri     = string
    verb    = string
  })
  default = null
}