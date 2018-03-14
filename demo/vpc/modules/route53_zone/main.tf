resource "aws_route53_zone" "main" {
  name = "${var.zone_name}"
}

variable "zone_name" { type = "string"}
