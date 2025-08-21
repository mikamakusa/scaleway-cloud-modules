provider "scaleway" {}

module "scaleway_bucket_object" {
  source = "../"
  bucket = [{
    name                = "bucket-with-acl"
    region              = "fr-par"
    force_destroy       = false
    versionning_enabled = true
    acl = [{
      access_control_policy = [
        {
          grant = [
            {
              permission = "FULL_CONTROL"
              grantee = [
                {
                  id   = "<project-id>:<project-id>"
                  type = "CanonicalUser"
                }
              ]
            }
          ]
          owner = [
            {
              id = "<project-id>"
            }
          ]
        }
      ]
    }]
    default_retention = [{
        mode = "GOVERNANCE"
        days = 1
      }]
  }]
}