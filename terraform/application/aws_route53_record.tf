resource "aws_route53_record" "dns-record" {
  zone_id = "${var.es_digital_hosted_zone}"
  name    = "${var.environment}-${var.app_name}"
  type    = "CNAME"
  ttl     = "60"

  records = [
    "${aws_lb.es-react-app-ecs-lb.dns_name}",
  ]
}
