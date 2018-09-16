resource "aws_cloudfront_origin_access_identity" "site" {
  comment = "used by cloudfront to access S3 assets"
}


resource "aws_cloudfront_distribution" "site" {
  origin {
    domain_name = "${aws_s3_bucket.site.bucket_regional_domain_name}"
    origin_id   = "site-origin"

    s3_origin_config {
      origin_access_identity = "${aws_cloudfront_origin_access_identity.site.cloudfront_access_identity_path}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  price_class         = "${var.cf_price_class}"

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.cf_logs.bucket_domain_name}"
    prefix          = "${var.prefix}/"
  }

  aliases = ["${var.site_domain}"]

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD", "OPTIONS"]
    cached_methods   = ["GET", "HEAD", "OPTIONS"]
    target_origin_id = "site-origin"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    # TODO !!
    viewer_protocol_policy = "allow-all"
    min_ttl                = 0
    default_ttl            = 0
    max_ttl                = 0
  }

  # custom_error_response {
  #     error_code         = 404
  #     response_code      = 404
  #     response_page_path = "/uk/404.html"
  # }

  restrictions {
    geo_restriction = {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = "${aws_acm_certificate.site_global.arn}"
    ssl_support_method  = "sni-only"
  }
}
