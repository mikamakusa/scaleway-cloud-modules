provider "scaleway" {}

module "scaleway_bucket_object" {
  source        = "../"
  bucket = [
    {
      name = "bucket-1"
      object = [
        {
          key       = "object_path"
          file      = "myfile"
        }
      ]
    }
  ]
}