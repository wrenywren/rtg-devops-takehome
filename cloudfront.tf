locals {
  s3_origin_id = "myS3Origin"
  cloudfront_ttl = 31536000
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  enabled = true
  is_ipv6_enabled = true
  comment = "My website's CloudFront distribution"
}