# scaleway_tem_domain
output "domains" {
  value = {
    for domain in scaleway_tem_domain.this : domain => {
      id                     = domain.id
      name                   = domain.name
      status                 = domain.status
      accept_tos             = domain.accept_tos
      created_at             = domain.created_at
      next_check_at          = domain.next_check_at
      last_valid_at          = domain.last_valid_at
      revoked_at             = domain.revoked_at
      last_error             = domain.last_error
      spf_config             = domain.spf_config
      dkim_config            = domain.dkim_config
      dmarc_name             = domain.dmarc_name
      dmarc_config           = domain.dmarc_config
      smtp_host              = domain.smtp_host
      smtp_port_unsecure     = domain.smtp_port_unsecure
      smtp_port              = domain.smtp_port
      smtp_port_alternative  = domain.smtp_port_alternative
      smtps_port             = domain.smtps_port
      smtps_port_alternative = domain.smtps_port_alternative
      smtps_auth_user        = domain.smtps_auth_user
      mx_blackhole           = domain.mx_blackhole
    }
  }
}

# scaleway_tem_blocked_list
output "blocked_lists" {
  value = {
    for blocked_list in scaleway_tem_blocked_list.this : blocked_list => {
      id     = blocked_list.id
      reason = blocked_list.reason
    }
  }
}

# scaleway_tem_domain_validation
output "domain_validations" {
  value = {
    for domain_validation in scaleway_tem_domain_validation.this : domain_validation => {
      id        = domain_validation.id
      validated = domain_validation.validated
    }
  }
}

# scaleway_tem_webhook
output "webhooks" {
  value = {
    for webhook in scaleway_tem_webhook.this : webhook => {
      id              = webhook.id
      organization_id = webhook.organization_id
      created_at      = webhook.created_at
      updated_at      = webhook.updated_at
      sns_arn         = webhook.sns_arn
      event_types     = webhook.event_types
    }
  }
}
