# Sign CloudFront requests to S3 so the distribution can read private files.
resource "aws_cloudfront_origin_access_control" "nextjsapp" {
  name                              = "nextjsapp-oac"
  description                       = "OAC for Next.js app"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

# Serve the static app through CloudFront
resource "aws_cloudfront_distribution" "nextjsapp" {

  origin {
    domain_name              = aws_s3_bucket.nextjsapp.bucket_regional_domain_name
    origin_id                = "s3-nextjsapp"
    origin_access_control_id = aws_cloudfront_origin_access_control.nextjsapp.id
  }

  enabled             = true
  default_root_object = "index.html"

  default_cache_behavior {
    allowed_methods = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id = "s3-nextjsapp"

    viewer_protocol_policy = "redirect-to-https"

    # forwarded_values {
    #   query_string = false

    #   cookies {
    #     forward = "none"
    #   }
    # }
    # Use the AWS-managed CachingOptimized policy instead of forwarded_values above.
    cache_policy_id = "658327ea-f89d-4fab-a63d-7e88639e58f6"
  }

  # Allow visitors from all countries.
  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  # Use the default TLS certificate for the CloudFront-provided domain name.
  viewer_certificate {
    cloudfront_default_certificate = true
  }
}
