provider "scaleway" {}

module "instance" {
  source = "../.."
  instance = [
    {
      name              = "test-mongodb-basic1"
      version           = "7.0.12"
      node_type         = "MGDB-PLAY2-NANO"
      node_number       = 1
      user_name         = "my_initial_user"
      password          = "thiZ_is_v&ry_s3cret"
      volume_size_in_gb = 5
      snapshot = [
        {
          name        = "name-snapshot-1"
          expires_at  = "2024-12-31T23:59:59Z"
        }
      ]
    }
  ]
}