## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_scaleway"></a> [scaleway](#requirement\_scaleway) | >= 2.59.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_scaleway"></a> [scaleway](#provider\_scaleway) | 2.59.0 |

## Modules

No modules.

## Usages

- [records](examples/records/main.tf)
- [registrations](examples/registrations/main.tf)
- [zones](examples/zones/main.tf)

## Resources

| Name | Type |
|------|------|
| [scaleway_domain_record.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_record) | resource |
| [scaleway_domain_registration.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_registration) | resource |
| [scaleway_domain_zone.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/resources/domain_zone) | resource |
| [scaleway_account_project.this](https://registry.terraform.io/providers/scaleway/scaleway/latest/docs/data-sources/account_project) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_geo_ip"></a> [geo\_ip](#input\_geo\_ip) | n/a | <pre>list(object({<br/>    data       = string<br/>    continents = optional(list(string))<br/>    countries  = optional(list(string))<br/>  }))</pre> | `[]` | no |
| <a name="input_http_service"></a> [http\_service](#input\_http\_service) | n/a | <pre>list(object({<br/>    ips          = list(string)<br/>    must_contain = string<br/>    strategy     = string<br/>    url          = string<br/>    user_agent   = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_owner_contact"></a> [owner\_contact](#input\_owner\_contact) | n/a | <pre>object({<br/>    address_line_1              = string<br/>    city                        = string<br/>    company_identification_code = string<br/>    country                     = string<br/>    email                       = string<br/>    firstname                   = string<br/>    lastname                    = string<br/>    legal_form                  = string<br/>    phone_number                = string<br/>    vat_identification_code     = string<br/>    zip                         = string<br/>  })</pre> | `null` | no |
| <a name="input_records"></a> [records](#input\_records) | n/a | <pre>list(object({<br/>    data     = string<br/>    dns_zone = string<br/>    type     = string<br/>    name     = optional(string)<br/>    ttl      = optional(number)<br/>    priority = optional(number)<br/>  }))</pre> | `[]` | no |
| <a name="input_registrations"></a> [registrations](#input\_registrations) | n/a | <pre>list(object({<br/>    domain_names      = list(string)<br/>    auto_renew        = optional(bool)<br/>    dnssec            = optional(bool)<br/>    duration_in_years = optional(number)<br/>    owner_contact_id  = optional(string)<br/>  }))</pre> | `[]` | no |
| <a name="input_view"></a> [view](#input\_view) | n/a | <pre>list(object({<br/>    data   = string<br/>    subnet = string<br/>  }))</pre> | `[]` | no |
| <a name="input_weighted"></a> [weighted](#input\_weighted) | n/a | <pre>list(object({<br/>    ip     = string<br/>    weight = number<br/>  }))</pre> | `[]` | no |
| <a name="input_zones"></a> [zones](#input\_zones) | n/a | <pre>list(object({<br/>    domain    = string<br/>    subdomain = string<br/>  }))</pre> | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_records"></a> [records](#output\_records) | Informations relatives aux dns records. |
| <a name="output_registrations"></a> [registrations](#output\_registrations) | Informations relatives aux dns registrations. |
| <a name="output_zones"></a> [zones](#output\_zones) | Informations relatives aux dns zones. |
