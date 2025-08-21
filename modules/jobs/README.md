## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.59.0 |

## Modules

No modules.

## Examples
```hcl
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
```

## Resources

| Name | Type |
|------|------|
| [scaleway_job_definition.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/job_definition) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_secret.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/secret) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cron"></a> [cron](#input\_cron) | n/a | <pre>object({<br/>    schedule = string<br/>    timezone = string<br/>  })</pre> | `null` | no |
| <a name="input_job_definitions"></a> [job\_definitions](#input\_job\_definitions) | n/a | <pre>map(object({<br/>    cpu_limit    = number<br/>    memory_limit = number<br/>    image_uri    = string<br/>    name         = string<br/>    description  = optional(string)<br/>    command      = optional(string)<br/>    timeout      = optional(string)<br/>    env          = optional(map(string))<br/>    region       = optional(string)<br/>  }))</pre> | `{}` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_secret"></a> [secret](#input\_secret) | n/a | <pre>object({<br/>    name            = optional(string)<br/>    path            = optional(string)<br/>    secret_id       = optional(string)<br/>    organization_id = optional(string)<br/>    region          = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_secret_reference"></a> [secret\_reference](#input\_secret\_reference) | n/a | <pre>object({<br/>    secret_version = optional(string)<br/>    file           = optional(string)<br/>    environment    = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_jobs"></a> [jobs](#output\_jobs) | n/a |
