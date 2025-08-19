resource "scaleway_inference_model" "this" {
  for_each   = { for model in var.models : model.name => model }
  name       = each.value.name
  url        = each.value.url
  secret     = sensitive(each.value.secret)
  region     = each.value.region
  project_id = data.scaleway_account_project.this.id
}

resource "scaleway_inference_deployment" "this" {
  for_each    = { for model in var.models : model.name => model if contains(keys(model), "deployment") && model.deployment != null }
  model_id    = scaleway_inference_model.this[each.key].id
  node_type   = lookup(each.value, "node_type")
  name        = lookup(each.value, "name")
  accept_eula = lookup(each.value, "accept_eula")
  tags        = concat(var.tags, lookup(each.value, "tags"))
  min_size    = lookup(each.value, "min_size")
  max_size    = lookup(each.value, "max_size")
  region      = lookup(each.value, "region")
  project_id  = data.scaleway_account_project.this.id

  dynamic "private_endpoint" {
    for_each = var.private_network != null && var.private_endpoint != null ? [""] : []
    iterator = private
    content {
      private_network_id = data.scaleway_vpc_private_network.this[0].id
      disable_auth       = var.private_endpoint.disable_auth
    }
  }

  dynamic "public_endpoint" {
    for_each = var.public_endpoint != null ? [""] : []
    iterator = public
    content {
      is_enabled   = var.public_endpoint.is_enabled
      disable_auth = var.public_endpoint.disable_auth
    }
  }
}