## TAGS // METADATA

variable "tags" {
  type    = map(string)
  default = {}
}

variable "metadata" {
  type    = map(string)
  default = {}
}

## RESOURCES

variable "bucket" {
  type = list(object({
    name               = string
    tags               = optional(map(any))
    region             = optional(string)
    force_destroy      = optional(bool)
    versioning_enabled = optional(bool)
    lifecycle_rule = optional(list(object({
      enabled                                = bool
      abort_incomplete_multipart_upload_days = optional(number)
      prefix                                 = optional(string)
      tags                                   = optional(map(any))
      expiration = optional(list(object({
        days = optional(number)
      })), [])
      transition = optional(list(object({
        storage_class = string
      })))
    })))
    object = optional(list(object({
      key           = string
      file          = optional(string)
      storage_class = optional(string)
      visibility    = optional(string)
      metadata      = optional(map(any))
      tags          = optional(map(any))
    })))
    acl = optional(list(object({
      acl                   = optional(string)
      expected_bucket_owner = optional(string)
      region                = optional(string)
      access_control_policy = optional(list(object({
        grant = optional(list(object({
          permission = string
          grantee = optional(list(object({
            id   = string
            type = string
          })), [])
        })), [])
        owner = optional(list(object({
          id           = string
          display_name = optional(string)
        })), [])
      })), [])
    })))
    default_retention = optional(list(object({
      mode  = string
      days  = optional(number)
      years = optional(number)
    })))
  }))

  validation {
    condition = alltrue([for a in var.bucket.*.object : true if a != null && contains(["STANDARD", "GLACIER", "ONEZONE_IA"], a.storage_class)])
    error_message = "Valid values are : 'STANDARD', 'GLACIER' or 'ONEZONE_IA'."
  }

  validation {
    condition     = alltrue([for b in var.bucket.*.lifecycle_rule : true if b != null && contains(["STANDARD", "GLACIER", "ONEZONE_IA"], b[0].transition[0].storage_class)])
    error_message = "Valid values are : 'STANDARD', 'GLACIER'or 'ONEZONE_IA'."
  }

  validation {
    condition     = alltrue([for c in var.bucket.*.object : true if c != null && contains(["public-read", "private"], c.visibility)])
    error_message = "Valid values are : 'public-read', 'private'."
  }

  validation {
    condition     = alltrue([for d in var.bucket.*.acl : true if d != null && contains(["READ", "WRITE", "READ_ACP", "WRITE_ACP", "FULL_CONTROL"], d[0].access_control_policy[0].grant[0].permission)])
    error_message = "Valid values are : 'READ', 'WRITE', 'READ_ACP', 'WRITE_ACP', 'FULL_CONTROL'."
  }

  validation {
    condition     = alltrue([for e in var.bucket.*.default_retention : true if e != null && contains(["GOVERNANCE", "COMPLIANCE"], e[0].mode)])
    error_message = "Valid values are : 'GOVERNANCE', 'COMPLIANCE'."
  }
}