output cloudfront_id {
  value = "${aws_cloudfront_distribution.site.id}"
}

output bucket {
  value = "${aws_s3_bucket.site.bucket}"
}
