# Allow CloudFront to read bucket objects without making the bucket public.
resource "aws_s3_bucket_policy" "nextjsapp" {
  bucket = aws_s3_bucket.nextjsapp.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowCloudFrontServicePrincipalReadOnly"
        Effect = "Allow"

        Principal = {
          Service = "cloudfront.amazonaws.com"
        }

        Action = "s3:GetObject"

        Resource = "${aws_s3_bucket.nextjsapp.arn}/*"

        # Restrict this read permission to the distribution created in cloudfront.tf.
        Condition = {
          StringEquals = {
            "AWS:SourceArn" = aws_cloudfront_distribution.nextjsapp.arn
          }
        }
      }
    ]
  })
}
