resource "aws_acm_certificate" "site_global" {
  provider = "aws.global"

  domain_name       = "${var.site_domain}"
  validation_method = "DNS"

  tags {
    Name        = "${var.prefix}-site"
  }
}

resource "aws_acm_certificate_validation" "site_global" {
  provider = "aws.global"

  certificate_arn         = "${aws_acm_certificate.site_global.arn}"
  validation_record_fqdns = ["${aws_route53_record.site_global_acm_validaton.fqdn}"]
}

resource "aws_route53_record" "site_global_acm_validaton" {
  zone_id = "${data.aws_route53_zone.main.id}"
  name    = "${aws_acm_certificate.site_global.domain_validation_options.0.resource_record_name}"
  type    = "${aws_acm_certificate.site_global.domain_validation_options.0.resource_record_type}"
  records = ["${aws_acm_certificate.site_global.domain_validation_options.0.resource_record_value}"]
  ttl     = 60
}
