module "databases" {
  source       = "../databases"
  instance     = var.instance
  project_name = var.project_name
}
