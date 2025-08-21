variable "project_name" {
  type = string
}

variable "tags" {
  type    = list(string)
  default = []
}

variable "secrets" {
  type = map(object({
    path        = optional(string)
    protected   = optional(bool)
    description = optional(string)
    tags        = optional(list(string))
    type        = optional(string)
    region      = optional(string)
    data        = optional(string)
  }))
  default = {}
}

variable "ephemeral_policy" {
  type = object({
    action                = string
    expires_once_accessed = optional(bool)
    ttl                   = optional(string)
  })
  default = null
}