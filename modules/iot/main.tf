resource "scaleway_iot_hub" "this" {
  for_each     = { for hub in var.hubs : hub.name => hub }
  name         = each.value.name
  product_plan = each.value.product_plan
  enabled      = true
  region       = each.value.region
  project_id   = data.scaleway_account_project.this.id
}

resource "scaleway_iot_device" "this" {
  for_each                   = { for hub in var.hubs : hub.name => hub if contains(keys(hub), "devices") && hub.devices != null }
  hub_id                     = scaleway_iot_hub.this[each.key].id
  name                       = lookup(each.value, "name")
  description                = lookup(each.value, "description")
  allow_insecure             = lookup(each.value, "allow_insecure")
  allow_multiple_connections = lookup(each.value, "allow_multiple_connections")
}

resource "scaleway_iot_network" "this" {
  for_each     = { for hub in var.hubs : hub.name => hub if contains(keys(hub), "networks") && hub.networks != null }
  hub_id       = scaleway_iot_hub.this[each.key].id
  name         = lookup(each.value, "name")
  type         = lookup(each.value, "type")
  topic_prefix = lookup(each.value, "topic_prefix")
}

resource "scaleway_iot_route" "this" {
  for_each = { for hub in var.hubs : hub.name => hub if contains(keys(hub), "routes") && hub.routes != null }
  hub_id   = scaleway_iot_hub.this[each.key].id
  name     = lookup(each.value, "name")
  topic    = lookup(each.value, "topic")

  dynamic "database" {
    for_each = var.instance != null ? [""] : []
    content {
      dbname   = lookup(each.value, "database_name")
      host     = module.databases.instance[0].endpoint_ip
      password = module.databases.instance[0].password
      port     = module.databases.instance[0].endpoint_port
      query    = lookup(each.value, "database_query")
      username = module.databases.instance[0].user_name
    }
  }

  dynamic "rest" {
    for_each = var.rest != null ? [""] : []
    content {
      headers = var.rest.headers
      uri     = var.rest.uri
      verb    = var.rest.verb
    }
  }

  dynamic "s3" {
    for_each = var.s3_bucket_name != null ? [""] : []
    content {
      bucket_name   = data.scaleway_object_bucket.this.name
      bucket_region = data.scaleway_object_bucket.this.region
      strategy      = lookup(each.value, "s3_strategy")
      object_prefix = lookup(each.value, "s3_object_prefix")
    }
  }
}