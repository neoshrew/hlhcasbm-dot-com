data "aws_route53_zone" "main" {
  name = "${var.route53_zone_name}"
}

resource "aws_route53_record" "site_a_record" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${var.site_domain}"
  type    = "A"

  alias {
    name                   = "${aws_cloudfront_distribution.site.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.site.hosted_zone_id}"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "site_aaaa_record" {
  zone_id = "${data.aws_route53_zone.main.zone_id}"
  name    = "${var.site_domain}"
  type    = "AAAA"

  alias {
    name                   = "${aws_cloudfront_distribution.site.domain_name}"
    zone_id                = "${aws_cloudfront_distribution.site.hosted_zone_id}"
    evaluate_target_health = false
  }
}
