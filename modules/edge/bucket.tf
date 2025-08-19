resource "scaleway_object_bucket" "this" {
  count = length(var.bucket)
  name  = lookup(var.bucket[count.index], "name")
  tags  = merge(var.tags, lookup(var.bucket[count.index], "tags"))
}