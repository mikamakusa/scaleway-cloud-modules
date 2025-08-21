module "sns" {
  source               = "../../"
  account_project_name = "project-1"
  sns = [
    {
      name                        = "sns-1"
      region                      = "fr-par"
      content_based_deduplication = true
      fifo_topic                  = true
      redrive_policy              = true
    }
  ]
}