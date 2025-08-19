module "function_with_cron_and_token" {
  source = "../../"
  function = [
    {
      name           = "function-1"
      namespace_name = "function-1-namespace"
      runtime        = "go118"
      handler        = "Handle"
      privacy        = "private"
      timeout        = 10
      zip_file       = "function.zip"
      deploy         = true
      schedule       = "0 0 * * *"
      expires_at     = "2022-10-18T11:35:15+02:00"
    }
  ]
}