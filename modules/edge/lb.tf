resource "scaleway_lb" "this" {
  count = length(var.lb)
  type  = lookup(var.lb[count.index], "type")
}

resource "scaleway_lb_frontend" "this" {
  count        = length(var.lb) == "0" ? "0" : length(var.lb_frontend)
  backend_id   = element(scaleway_lb_backend.this.*.id, lookup(var.lb_frontend[count.index], "backend_id"))
  inbound_port = lookup(var.lb_frontend[count.index], "inbound_port")
  lb_id        = element(scaleway_lb.this.*.id, lookup(var.lb_frontend[count.index], "lb_id"))
}

resource "scaleway_lb_backend" "this" {
  count            = length(var.lb) == "0" ? "0" : length(var.lb_backend)
  forward_port     = lookup(var.lb_backend[count.index], "forward_port")
  forward_protocol = lookup(var.lb_backend[count.index], "forward_protocol")
  lb_id            = element(scaleway_lb.this.*.id, lookup(var.lb_backend[count.index], "lb_id"))
}


