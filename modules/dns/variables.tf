variable "records" {
  type = list(object({
    data     = string
    dns_zone = string
    type     = string
    name     = optional(string)
    ttl      = optional(number)
    priority = optional(number)
  }))
  default = []

  validation {
    condition     = alltrue([for ttl in var.records : true if contains(["A", "AAAA", "MX", "CNAME", "DNAME", "ALIAS", "NS", "PTR", "SRV", "TXT", "TLSA", "CAA"], ttl.ttl)])
    error_message = "Valid values are : A, AAAA, MX, CNAME, DNAME, ALIAS, NS, PTR, SRV, TXT, TLSA, or CAA."
  }
}

variable "geo_ip" {
  type = list(object({
    data       = string
    continents = optional(list(string))
    countries  = optional(list(string))
  }))
  default = []
}

variable "weighted" {
  type = list(object({
    ip     = string
    weight = number
  }))
  default = []
}

variable "view" {
  type = list(object({
    data   = string
    subnet = string
  }))
  default = []
}

variable "http_service" {
  type = list(object({
    ips          = list(string)
    must_contain = string
    strategy     = string
    url          = string
    user_agent   = optional(string)
  }))
  default = []

  validation {
    condition     = alltrue([for strategy in var.http_service : true if contains(["random", "hashed", "all"], strategy.strategy)])
    error_message = "Valid values are : random, hashed, or all."
  }
}

variable "registrations" {
  type = list(object({
    domain_names      = list(string)
    auto_renew        = optional(bool)
    dnssec            = optional(bool)
    duration_in_years = optional(number)
    owner_contact_id  = optional(string)
  }))
  default = []
}

variable "owner_contact" {
  type = object({
    address_line_1              = string
    city                        = string
    company_identification_code = string
    country                     = string
    email                       = string
    firstname                   = string
    lastname                    = string
    legal_form                  = string
    phone_number                = string
    vat_identification_code     = string
    zip                         = string
  })
  default = null
}

variable "zones" {
  type = list(object({
    domain    = string
    subdomain = string
  }))
  default = []
}