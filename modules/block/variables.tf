variable "metadata" {
  type    = map(string)
  default = {}
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "block_volumes" {
  type = list(object({
    iops       = number
    size_in_gb = number
    name       = optional(string)
    tags       = optional(list(string))
    zone       = optional(string)
    snapshots = optional(list(object({
      name = string
      zone = optional(string)
      tags = optional(list(string))
      import = optional(list(object({
        bucket_name = string
        folder      = string
        file        = string
      })))
      export = optional(list(object({
        bucket_name = string
        folder      = string
        file        = string
      })))
    })))
  }))
  default = []
}

variable "cors_rule" {
  type = list(object({
    allowed_methods = list(string)
    allowed_origins = list(string)
    allowed_headers = optional(list(string))
    expose_headers  = optional(list(string))
    max_age_seconds = optional(number)
  }))
  default = []
}

variable "lifecycle_rule" {
  type = list(object({
    enabled                                = bool
    abort_incomplete_multipart_upload_days = optional(number)
    id                                     = optional(string)
    tags                                   = optional(map(string))
    storage_class                          = string
    transition_days                        = optional(string)
    expiration_days                        = number
  }))
  default = []

  validation {
    condition     = alltrue([for rule in var.lifecycle_rule : true if rule != null && contains(["STANDARD", "GLACIER", "ONEZONE_IA"], rule.storage_class)])
    error_message = "Valid values are : 'STANDARD', 'GLACIER'or 'ONEZONE_IA'."
  }
}

variable "buckets" {
  type = list(object({
    name          = string
    tags          = optional(map(string))
    region        = optional(string)
    force_destroy = optional(bool)
    versioning    = optional(bool)
    objects = optional(list(object({
      key              = string
      file             = optional(string)
      content          = optional(string)
      content_base64   = optional(string)
      storage_class    = optional(string)
      visibility       = optional(string)
      metadata         = optional(map(string))
      tags             = optional(map(string))
      sse_customer_key = optional(string)
    })))
  }))
  default = []

  validation {
    condition     = alltrue([for class in var.buckets.*.objects : true if class != null && contains(["STANDARD", "GLACIER", "ONEZONE_IA"], class.storage_class)])
    error_message = "Valid values are : 'STANDARD', 'GLACIER' or 'ONEZONE_IA'."
  }

  validation {
    condition     = alltrue([for object in var.buckets.*.objects : true if object != null && contains(["public-read", "private"], object.visibility)])
    error_message = "Valid values are : 'public-read', 'private'."
  }

}