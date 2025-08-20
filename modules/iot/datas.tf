data "scaleway_account_project" "this" {
  name = var.project_name
}

data "scaleway_object_bucket" "this" {
  count = var.s3_bucket_name ? 1 : 0
  name  = var.s3_bucket_name
}