resource "aws_s3_bucket" "cf_logs" {
  bucket = "${var.global_prefix}-${var.prefix}-site-cloudfront-logs"
  acl    = "private"
  region = "${var.aws_region}"

  lifecycle_rule {
    enabled = true

    expiration {
        days = "${var.log_expiration_days}"
    }
  }
}

resource "aws_s3_bucket" "site" {
  bucket = "${var.global_prefix}-${var.prefix}-site"
  acl    = "private"
  region = "${var.aws_region}"

  versioning {
    enabled = true
  }

  lifecycle_rule {
    enabled = true

    noncurrent_version_expiration {
      days    = 30
    }
  }

  tags {
    Name = "${var.global_prefix}-${var.prefix}-site"
  }
}

resource "aws_s3_bucket_policy" "site_cdn_access" {
  bucket = "${aws_s3_bucket.site.id}"
  policy = "${data.aws_iam_policy_document.site_s3_access.json}"
}
