# Get zone id based on zone name
data "aws_route53_zone" "main" {
  name         = "${var.hosted_zone}"
  private_zone = false
}

resource "aws_route53_record" "www" {
  zone_id      = "${data.aws_route53_zone.main.zone_id}"
  name         = "${var.record_name}-${format("%02d", count.index + 1)}"
  type         = "A"
  ttl          = "300"
  records      = ["${element(var.ec2_eip, count.index)}"]
  count        = "${var.count}"
}

output "record_name" { value = "${aws_route53_record.www.*.fqdn}" }
