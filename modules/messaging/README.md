## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | 2.57.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.57.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [scaleway_mnq_nats_account.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_nats_account) | resource |
| [scaleway_mnq_nats_credentials.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_nats_credentials) | resource |
| [scaleway_mnq_sns.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_sns) | resource |
| [scaleway_mnq_sns_credentials.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_sns_credentials) | resource |
| [scaleway_mnq_sns_topic.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_sns_topic) | resource |
| [scaleway_mnq_sns_topic_subscription.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_sns_topic_subscription) | resource |
| [scaleway_mnq_sqs.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_sqs) | resource |
| [scaleway_mnq_sqs_credentials.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_sqs_credentials) | resource |
| [scaleway_mnq_sqs_queue.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/resources/mnq_sqs_queue) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/2.57.0/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_account_project_name"></a> [account\_project\_name](#input\_account\_project\_name) | n/a | `string` | n/a | yes |
| <a name="input_nats"></a> [nats](#input\_nats) | n/a | <pre>list(object({<br/>    name       = optional(string)<br/>    region     = optional(string)<br/>    account_id = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_sns"></a> [sns](#input\_sns) | n/a | <pre>list(object({<br/>    region                      = optional(string)<br/>    project_id                  = optional(string)<br/>    name                        = optional(string)<br/>    name_prefix                 = optional(string)<br/>    content_based_deduplication = optional(bool)<br/>    fifo_topic                  = optional(bool)<br/>    protocol                    = optional(string)<br/>    topic_arn                   = optional(string)<br/>    topic_id                    = optional(string)<br/>    redrive_policy              = optional(bool)<br/>    sns_endpoint                = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_sqs"></a> [sqs](#input\_sqs) | n/a | <pre>list(object({<br/>    region                      = optional(string)<br/>    name                        = optional(string)<br/>    name_prefix                 = optional(string)<br/>    sqs_endpoint                = optional(string)<br/>    fifo_queue                  = optional(bool)<br/>    content_based_deduplication = optional(bool)<br/>    receive_wait_time_seconds   = optional(number)<br/>    visibility_timeout_seconds  = optional(number)<br/>    message_max_age             = optional(number)<br/>    message_max_size            = optional(number)<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nats_account"></a> [nats\_account](#output\_nats\_account) | n/a |
| <a name="output_nats_credentials"></a> [nats\_credentials](#output\_nats\_credentials) | n/a |
| <a name="output_sns"></a> [sns](#output\_sns) | n/a |
| <a name="output_sns_credentials"></a> [sns\_credentials](#output\_sns\_credentials) | n/a |
| <a name="output_sns_topic"></a> [sns\_topic](#output\_sns\_topic) | n/a |
| <a name="output_sns_topic_subscription"></a> [sns\_topic\_subscription](#output\_sns\_topic\_subscription) | n/a |
| <a name="output_sqs"></a> [sqs](#output\_sqs) | # scaleway\_mnq\_sqs |
| <a name="output_sqs_credentials"></a> [sqs\_credentials](#output\_sqs\_credentials) | # scaleway\_mnq\_sqs\_credentials |
| <a name="output_sqs_queue"></a> [sqs\_queue](#output\_sqs\_queue) | # scaleway\_mnq\_sqs\_queue |
