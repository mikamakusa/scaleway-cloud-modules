provider "scaleway" {}

variable "secret" {
  type      = string
  sensitive = true
}

module "inference" {
  source       = "../"
  project_name = "xxxxxx"
  vpc = {
    name = "foobar"
  }
  private_network = {
    name = "foobar"
  }
  models = [{
    name   = "my-awesome-model"
    url    = "https://huggingface.co/agentica-org/DeepCoder-14B-Preview"
    secret = var.secret
    deployment = [{
      name        = "test-inference-deployment-basic"
      node_type   = "H100"
      accept_eula = true
      public_endpoint = [
        {
          is_enabled = true
        }
      ]
    }]
  }]
}