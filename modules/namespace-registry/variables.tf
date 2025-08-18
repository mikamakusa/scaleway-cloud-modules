variable "registry_namespace" {
  type = map(object({
    description = optional(string)
    is_public   = optional(bool)
    region      = optional(string)
  }))
  default = {}
}