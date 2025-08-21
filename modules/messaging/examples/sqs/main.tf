module "sqs" {
  source               = "../../"
  account_project_name = "project-1"
  sqs = [
    {
      region                      = "fr-par"
      name                        = "sqs-1"
      fifo_queue                  = true
      content_based_deduplication = true
      receive_wait_time_seconds   = 15
      visibility_timeout_seconds  = 60
      message_max_age             = 100000
      message_max_size            = 50000
    }
  ]
}