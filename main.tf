# This just sets the aws provider default region to us-east-1
provider "aws" {
  region = "us-east-1"
}


## NOTE: I created the s3 bucket 'rtg-takehome-bucket' via the aws cli command as the using the s3 bucket
## in this backend state below required that the bucket be created prior to the build starting:
# I did attempt to use moduels to try and create this bucket first without using the cli, but
# i kept failing terribly

# aws s3api create-bucket --bucket rtg-state-bucket #

# Here we define out Terraform state which will allow us to keep track of the
# state of our resources this enables terraform to perform state transitions 
# and only change resources 
# which have actually changed. To run terraform apply - we need state.
terraform {
  backend "s3" {
    bucket = "rtg-state-bucket"
    key    = "rtg-takehome.com.tfstate"
    region = "us-east-1"
  }
}

# This is just our bucket config.
# It has a name, and an acl of "public-read", a public bucket policy
# I kept the policy simple for this assingments purpose

resource "aws_s3_bucket" "b" {
  bucket = "rtg-takehome.com"
  acl    = "public-read"
  website {
    index_document = "index.html"
    error_document = "404.html"
  }

  policy = <<POLICY
{
      "Version": "2012-10-17",
      "Statement": [
        {
          "Sid": "PublicReadGetObject",
          "Effect": "Allow",
          "Principal": "*",
          "Action": "s3:GetObject",
          "Resource": "arn:aws:s3:::rtg-takehome.com/*"
        }
      ]
    }
  POLICY
}

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
}