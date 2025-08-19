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

## Usage
-> [example](examples/main.tf)
```hcl
provider "scaleway" {}

variable "secret" {
  type      = string
  sensitive = true
}

module "inference" {
  source       = "../"
  project_name = "xxxxxx"
  vpc = {
    name = "foobar"
  }
  private_network = {
    name = "foobar"
  }
  models = [{
    name   = "my-awesome-model"
    url    = "https://huggingface.co/agentica-org/DeepCoder-14B-Preview"
    secret = var.secret
    deployment = [{
      name        = "test-inference-deployment-basic"
      node_type   = "H100"
      accept_eula = true
      public_endpoint = [
        {
          is_enabled = true
        }
      ]
    }]
  }]
}
```

## Resources

| Name | Type |
|------|------|
| [scaleway_inference_deployment.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/inference_deployment) | resource |
| [scaleway_inference_model.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/inference_model) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |
| [scaleway_ipam_ip.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/ipam_ip) | data source |
| [scaleway_vpc.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc) | data source |
| [scaleway_vpc_private_network.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/vpc_private_network) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_models"></a> [models](#input\_models) | n/a | <pre>list(object({<br/>    name   = string<br/>    url    = string<br/>    secret = optional(string)<br/>    region = optional(string)<br/>    deployment = optional(list(object({<br/>      node_type   = string<br/>      name        = optional(string)<br/>      accept_eula = optional(bool)<br/>      tags        = optional(list(string))<br/>      min_size    = optional(number)<br/>      max_size    = optional(number)<br/>      region      = optional(string)<br/>    })))<br/>  }))</pre> | `[]` | no |
| <a name="input_private_endpoint"></a> [private\_endpoint](#input\_private\_endpoint) | n/a | <pre>list(object({<br/>    disable_auth = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_private_network"></a> [private\_network](#input\_private\_network) | n/a | <pre>object({<br/>    name = optional(string)<br/>  })</pre> | `null` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_public_endpoint"></a> [public\_endpoint](#input\_public\_endpoint) | n/a | <pre>list(object({<br/>    is_enabled = optional(bool)<br/>    disable_auth = optional(bool)<br/>  }))</pre> | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `list(string)` | `[]` | no |
| <a name="input_vpc"></a> [vpc](#input\_vpc) | n/a | <pre>object({<br/>    name            = optional(string)<br/>    is_default      = optional(bool)<br/>    organization_id = optional(string)<br/>  })</pre> | `null` | no |

## Outputs

No outputs.
