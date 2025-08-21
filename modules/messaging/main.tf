resource "scaleway_mnq_nats_account" "this" {
  for_each   = { for a in var.nats : a.name => a }
  name       = join("-", [each.value.name, "account"])
  region     = each.value.region
  project_id = data.scaleway_account_project.this.project_id
}

resource "scaleway_mnq_nats_credentials" "this" {
  for_each   = { for b in var.nats : b.account_id != null ? b.name : null => b if b.account_id != null }
  account_id = scaleway_mnq_nats_account.this[join("-", [each.value.name, "account"])].id
  name       = join("-", [each.value.name, "credentials"])
  region     = each.value.region
}

resource "scaleway_mnq_sns" "this" {
  for_each   = { for c in var.sns : c.name != null ? c.name : null => c if c.name != null }
  region     = each.value.region
  project_id = data.scaleway_account_project.this.project_id
}

resource "scaleway_mnq_sns_credentials" "this" {
  for_each   = { for d in var.sns : d.name != null ? d.name : null => d if d.name != null }
  name       = join("-", [each.value.name, "credentials"])
  project_id = data.scaleway_account_project.this.project_id

  permissions {
    can_manage  = true
    can_publish = true
    can_receive = true
  }
}

resource "scaleway_mnq_sns_topic" "this" {
  for_each                    = { for e in var.sns : e.fifo_topic != null ? e.name : null => e if e.fifo_topic != null }
  access_key                  = scaleway_mnq_sns_credentials.this[join("-", [each.value.name, "credentials"])].access_key
  secret_key                  = scaleway_mnq_sns_credentials.this[join("-", [each.value.name, "credentials"])].secret_key
  name                        = join("-", [each.value.name, "topic"])
  name_prefix                 = each.value.name_prefix
  content_based_deduplication = each.value.content_based_deduplication
  fifo_topic                  = each.value.fifo_topic
  sns_endpoint                = scaleway_mnq_sns.this[each.value.name].endpoint
  region                      = scaleway_mnq_sns.this[each.value.name].region
  project_id                  = data.scaleway_account_project.this.project_id
}

resource "scaleway_mnq_sns_topic_subscription" "this" {
  for_each       = { for f in var.sns : f.protocol != null ? f.name : null => f if f.protocol != null }
  access_key     = scaleway_mnq_sns_credentials.this[join("-", [each.value.name, "credentials"])].access_key
  protocol       = each.value.protocol
  secret_key     = scaleway_mnq_sns_credentials.this[join("-", [each.value.name, "credentials"])].secret_key
  topic_id       = scaleway_mnq_sns_topic.this[join("-", [each.value.name, "topic"])].id
  redrive_policy = each.value.redrive_policy
  sns_endpoint   = scaleway_mnq_sns.this[each.value.name].endpoint
  region         = scaleway_mnq_sns.this[each.value.name].region
  project_id     = data.scaleway_account_project.this.project_id
}

resource "scaleway_mnq_sqs" "this" {
  for_each   = { for g in var.sqs : g.name != null ? g.name : null => g if g.name != null }
  region     = each.value.region
  project_id = data.scaleway_account_project.this.project_id
}

resource "scaleway_mnq_sqs_credentials" "this" {
  for_each   = { for h in var.sqs : h.name != null ? h.name : null => h if h.name != null }
  name       = join("-", [each.value.name, "credentials"])
  project_id = data.scaleway_account_project.this.project_id

  permissions {
    can_manage  = true
    can_publish = true
    can_receive = true
  }
}

resource "scaleway_mnq_sqs_queue" "this" {
  for_each                    = { for i in var.sqs : i.fifo_queue != null ? i.name : null => i if i.fifo_queue != null }
  access_key                  = scaleway_mnq_sqs_credentials.this[join("-", [each.value.name, "credentials"])].access_key
  secret_key                  = scaleway_mnq_sqs_credentials.this[join("-", [each.value.name, "credentials"])].secret_key
  name                        = each.value.name
  name_prefix                 = each.value.name_prefix
  sqs_endpoint                = scaleway_mnq_sqs.this[each.value.name].endpoint
  fifo_queue                  = each.value.fifo_queue
  content_based_deduplication = each.value.content_based_deduplication
  receive_wait_time_seconds   = each.value.receive_wait_time_seconds
  visibility_timeout_seconds  = each.value.visibility_timeout_seconds
  message_max_age             = each.value.message_max_age
  message_max_size            = each.value.message_max_size
  region                      = scaleway_mnq_sqs.this[each.value.name].region
  project_id                  = data.scaleway_account_project.this.project_id
}