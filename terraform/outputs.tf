output "s3_bucket_name" {
  description = "Name of the S3 bucket hosting nextjs app"
  value       = aws_s3_bucket.nextjsapp.bucket
}

output "cloudfront_distribution_id" {
  description = "CloudFront distribution ID"
  value       = aws_cloudfront_distribution.nextjsapp.id
}

output "cloudfront_domain_name" {
  description = "CloudFront distribution domain name"
  value       = aws_cloudfront_distribution.nextjsapp.domain_name
}
