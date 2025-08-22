output "hosting" {
  value = {
    for host in scaleway_webhosting.this : host => {
      id                    = host.id
      status                = host.status
      created_at            = host.created_at
      updated_at            = host.updated_at
      platform_hostname     = host.platform_hostname
      platform_number       = host.platform_number
      offer_name            = host.offer_name
      option_ids            = host.option_ids
      dns_status            = host.dns_status
      username              = host.username
      cpanel_urls_dashboard = host.cpanel_urls[0].dashboard
      cpanel_urls_webmail   = host.cpanel_urls[0].webmail
    }
  }
}