output "api_key" {
  value = {
    for a in scaleway_iam_api_key.this : a => {
      id          = a.id
      created_at  = a.created_at
      updated_at  = a.updated_at
      editable    = a.editable
      access_key  = a.access_key
      secret_key  = a.secret_key
      creation_ip = a.creation_ip
    }
  }
}

output "ssh_key" {
  value = {
    for a in scaleway_iam_ssh_key.this : a => {
      id              = a.id
      fingerprint     = a.fingerprint
      organization_id = a.organization_id
      created_at      = a.created_at
      updated_at      = a.updated_at
    }
  }
}

output "application" {
  value = {
    for a in scaleway_iam_application.this : a => {
      id         = a.id
      created_at = a.created_at
      updated_at = a.updated_at
      editable   = a.editable
    }
  }
}

output "group" {
  value = {
    for a in scaleway_iam_group.this : a => {
      id = a.id
    }
  }
}

output "group_membership" {
  value = {
    for a in scaleway_iam_group_membership.this : a => {
      id = a.id
    }
  }
}

output "policy" {
  value = {
    for a in scaleway_iam_policy.this : a => {
      id         = a.id
      created_at = a.created_at
      updated_at = a.updated_at
      editable   = a.editable
    }
  }
}

output "user" {
  value = {
    for a in scaleway_iam_user.this : a => {
      id                   = a.id
      created_at           = a.created_at
      updated_at           = a.updated_at
      deletable            = a.deletable
      last_login_at        = a.last_login_at
      type                 = a.type
      status               = a.status
      mfa                  = a.mfa
      account_root_user_id = a.account_root_user_id
      locked               = a.locked
    }
  }
}
