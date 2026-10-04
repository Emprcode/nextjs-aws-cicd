data "aws_caller_identity" "current" {}

# Create s3 bucket
resource "aws_s3_bucket" "nextjsapp" {
  bucket = "nextjs-app-${data.aws_caller_identity.current.account_id}"
}

# Block public S3 access; visitors retrieve the files through CloudFront.
resource "aws_s3_bucket_public_access_block" "nextjsapp" {
  bucket = aws_s3_bucket.nextjsapp.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "nextjsapp" {
  bucket = aws_s3_bucket.nextjsapp.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Encrypt stored objects by default using S3-managed encryption keys.
resource "aws_s3_bucket_server_side_encryption_configuration" "nextjsapp" {
  bucket = aws_s3_bucket.nextjsapp.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}
