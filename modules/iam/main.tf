resource "scaleway_iam_api_key" "this" {
  count              = length(var.api_key)
  description        = lookup(var.api_key[count.index], "description")
  application_id     = element(scaleway_iam_application.this.*.id, lookup(var.api_key[count.index], "application_id"))
  user_id            = element(scaleway_iam_user.this.*.id, lookup(var.api_key[count.index], "user_id"))
  expires_at         = lookup(var.api_key[count.index], "expires_at")
}

resource "scaleway_iam_ssh_key" "this" {
  count      = length(var.ssh_key)
  public_key = lookup(var.ssh_key[count.index], "public_key")
  name       = lookup(var.ssh_key[count.index], "name")
  disabled   = lookup(var.ssh_key[count.index], "disabled")
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_iam_application" "this" {
  count           = length(var.application)
  name            = lookup(var.application[count.index], "name")
  description     = lookup(var.application[count.index], "description")
  tags            = concat(var.tags, lookup(var.application[count.index], "tags"))
  organization_id = lookup(var.application[count.index], "organization_id")
}

resource "scaleway_iam_group" "this" {
  count               = length(var.group)
  name                = lookup(var.group[count.index], "name")
  description         = lookup(var.group[count.index], "description")
  tags                = concat(var.tags, lookup(var.group[count.index], "tags"))
  application_ids     = [element(scaleway_iam_application.this.*.id, lookup(var.api_key[count.index], "application_id"))]
  user_ids            = [element(scaleway_iam_user.this.*.id, lookup(var.api_key[count.index], "user_id"))]
  external_membership = lookup(var.group[count.index], "external_membership")
  organization_id     = lookup(var.group[count.index], "organization_id")
}

resource "scaleway_iam_group_membership" "this" {
  count          = length(var.group_membership)
  group_id       = element(scaleway_iam_group.this.*.id, lookup(var.group_membership[count.index], "group_id"))
  user_id        = element(scaleway_iam_user.this.*.id, lookup(var.group_membership[count.index], "user_id"))
  application_id = element(scaleway_iam_application.this.*.id, lookup(var.group_membership[count.index], "application_id"))
}

resource "scaleway_iam_policy" "this" {
  count          = length(var.policy)
  name           = lookup(var.policy[count.index], "name")
  description    = lookup(var.policy[count.index], "description")
  tags           = lookup(var.policy[count.index], "tags")
  no_principal   = lookup(var.policy[count.index], "no_principal")
  application_id = element(scaleway_iam_application.this.*.id, lookup(var.policy[count.index], "application_id"))

  dynamic "rule" {
    for_each = lookup(var.policy[count.index], "rule") == null ? [] : [""]
    content {
      permission_set_names = lookup(rule.value, "permission_set_names")
      project_ids          = data.scaleway_account_project.this.id
      organization_id      = lookup(rule.value, "organization_id")
      condition            = lookup(rule.value, "condition")
    }
  }
}

resource "scaleway_iam_user" "this" {
  count               = length(var.user)
  email               = lookup(var.user[count.index], "email")
  tags                = lookup(var.user[count.index], "tags")
  username            = lookup(var.user[count.index], "username")
  password            = lookup(var.user[count.index], "password")
  phone_number        = lookup(var.user[count.index], "phone_number")
  send_password_email = lookup(var.user[count.index], "send_password_email")
  send_welcome_email  = lookup(var.user[count.index], "send_welcome_email")
  first_name          = lookup(var.user[count.index], "first_name")
  last_name           = lookup(var.user[count.index], "last_name")
  locale              = lookup(var.user[count.index], "locale")
}