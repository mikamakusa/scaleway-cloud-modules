terraform {
  required_providers {
    scaleway = {
      source  = "scaleway/scaleway"
      version = ">= 2.57.0"
    }
  }
}

provider "scaleway" {}

module "jobs" {
  source = "../"
  project_name = "my-project"
  job_definitions = {
    job-1 = {
      cpu_limit    = 140
      memory_limit = 256
      image_uri    = "docker.io/alpine:latest"
      command      = "ls"
      timeout      = "10m"
    }
  }
  cron = {
    schedule = "5 4 1 * *"
    timezone = "Europe/Paris"
  }
}
