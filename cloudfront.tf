locals {
  s3_origin_id = "myS3Origin"
  cloudfront_ttl = 31536000
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }
    domain_name = aws_s3_bucket.b.website_endpoint
    origin_id   = local.s3_origin_id
  }

  enabled         = true
  is_ipv6_enabled = true
  comment         = "My website's CloudFront distribution"

  default_cache_behavior {
    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true
    target_origin_id = local.s3_origin_id

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = local.cloudfront_ttl
    default_ttl            = local.cloudfront_ttl
    max_ttl                = local.cloudfront_ttl
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

}