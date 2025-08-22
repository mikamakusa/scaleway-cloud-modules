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
module "transact_email" {
  source = "./"
  domains = [{
    accept_tos = true
    name       = "example.com"
    region     = "fr-par"
    blocked_lists = [{
      email  = "spam@example.com"
      type   = "mailbox_full"
      reason = "Spam detected"
    }]
    domain_validations = [{
      timeout   = 300
    }]
    webhooks = [{
      event_types = ["email_delivered", "email_bounced"]
      sns_arn     = "arn:scw:sns:fr-par:project-xxxx:your-sns-topic"
    }]
  }]
  project_name = "my-project-tem"
}
```

## Resources

| Name | Type |
|------|------|
| [scaleway_tem_blocked_list.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/tem_blocked_list) | resource |
| [scaleway_tem_domain.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/tem_domain) | resource |
| [scaleway_tem_domain_validation.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/tem_domain_validation) | resource |
| [scaleway_tem_webhook.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/tem_webhook) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domains"></a> [domains](#input\_domains) | n/a | <pre>list(object({<br/>    accept_tos = bool<br/>    name       = string<br/>    region     = optional(string)<br/>    autoconfig = optional(bool)<br/>    blocked_lists = optional(list(object({<br/>      email  = string<br/>      type   = string<br/>      reason = optional(string)<br/>    })))<br/>    domain_validations = optional(list(object({<br/>      timeout = optional(number)<br/>    })))<br/>    webhooks = optional(list(object({<br/>      event_types = list(string)<br/>      sns_arn     = string<br/>      name        = optional(string)<br/>    })))<br/>  }))</pre> | n/a | yes |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_blocked_lists"></a> [blocked\_lists](#output\_blocked\_lists) | scaleway\_tem\_blocked\_list |
| <a name="output_domain_validations"></a> [domain\_validations](#output\_domain\_validations) | scaleway\_tem\_domain\_validation |
| <a name="output_domains"></a> [domains](#output\_domains) | scaleway\_tem\_domain |
| <a name="output_webhooks"></a> [webhooks](#output\_webhooks) | scaleway\_tem\_webhook |
