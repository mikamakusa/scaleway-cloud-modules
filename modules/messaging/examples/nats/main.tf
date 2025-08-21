module "nats" {
  source               = "../../"
  account_project_name = "project-1"
  nats = [
    {
      name   = "nats-1"
      region = "fr-par"
    }
  ]
}