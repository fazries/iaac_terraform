resource "aws_security_group" "sg" {
  name        = "${var.name}"
  vpc_id      = "${var.vpc_id}"
  description = "${var.name} ${lookup(var.tags,"env")} security groups"

  tags {
      Service     = "${lookup(var.tags,"apps")}"
      Environment = "${lookup(var.tags,"env")}"
  }
}

resource "aws_security_group_rule" "egress_allow_all" {
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]

  security_group_id = "${aws_security_group.sg.id}"
}

output "sg_id" {
   value = "${aws_security_group.sg.id}"
}

variable "name"   { type = "string" }
variable "vpc_id" { type = "string" }
variable "tags"   { type = "map" }
