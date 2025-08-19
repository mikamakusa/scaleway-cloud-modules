provider "scaleway" {}

variable "application" {
  type = any
}

variable "api_key" {
  type = any
}

resource "time_rotating" "rotate_after_a_year" {
  rotation_years = 1
}

module "api_key" {
  source = "../../"
  application = [{
    id          = "0"
    name        = "My application"
    description = "a description"
  }]
  api_key = [{
    id             = "5"
    application_id = "0"
    expires_at     = time_rotating.rotate_after_a_year.rotation_rfc3339
  }]
}