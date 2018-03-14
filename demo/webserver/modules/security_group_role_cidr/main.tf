resource "aws_security_group_rule" "ingress_cidr_allow" {
  type              = "ingress"
  from_port         = "${var.ingress_port[count.index]}"
  to_port           = "${var.ingress_port[count.index]}"
  protocol          = "tcp"
  cidr_blocks       = ["${var.cidr_blocks}"]
  count             = "${length(var.ingress_port)}"

  security_group_id = "${var.security_group_id}"
}

variable "security_group_id" { type = "string" }
variable "ingress_port"      { type = "list" }
variable "cidr_blocks"       { type = "list" }
