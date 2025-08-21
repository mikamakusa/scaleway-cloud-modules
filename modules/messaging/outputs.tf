output "nats_account" {
  value = try(
    {
      for a, b in scaleway_mnq_nats_account.this : b => {
        id       = b.id
        endpoint = b.endpoint
      }
    }
  )
}

output "nats_credentials" {
  value = try(
    {
      for c, d in scaleway_mnq_nats_credentials.this : d => {
        id   = d.id
        file = d.file
      }
    }
  )
}

output "sns" {
  value = try(
    {
      for e, f in scaleway_mnq_sns.this : f => {
        id       = f.id
        endpoint = f.endpoint
      }
    }
  )
}

output "sns_credentials" {
  value = try(
    {
      for g, h in scaleway_mnq_sns_credentials.this : h => {
        id         = h.id
        access_key = h.access_key
        secret_key = h.secret_key
      }
    }
  )
}

output "sns_topic" {
  value = try(
    {
      for k, l in scaleway_mnq_sns_topic.this : l => {
        id  = l.id
        arn = l.arn
      }
    }
  )
}

output "sns_topic_subscription" {
  value = try(
    {
      for i, j in scaleway_mnq_sns_topic_subscription.this : j => {
        id  = j.id
        arn = j.arn
      }
    }
  )
}

## scaleway_mnq_sqs
output "sqs" {
  value = try(
    {
      for k, l in scaleway_mnq_sqs.this : l => {
        id       = l.id
        endpoint = l.endpoint
      }
    }
  )
}

## scaleway_mnq_sqs_credentials
output "sqs_credentials" {
  value = try(
    {
      for m, n in scaleway_mnq_sqs_credentials.this : n => {
        id         = n.id
        access_key = n.access_key
        secret_key = n.secret_key
      }
    }
  )
}

## scaleway_mnq_sqs_queue
output "sqs_queue" {
  value = try(
    {
      for o, p in scaleway_mnq_sqs_queue.this : p => {
        id  = p.id
        url = p.url
      }
    }
  )
}