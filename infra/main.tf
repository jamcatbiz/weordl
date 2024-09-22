## ------------------------------------------------------------
## S3 BUCKET, ENCRYPTION, VERSIONING, POLICIES, ETC.
## This implementation uses Origin Access Control to expose bucket.
## ------------------------------------------------------------
resource "aws_s3_bucket" "this" {
  bucket = local.s3_bucket_name[var.environment]
}
import {
  to = aws_s3_bucket.this
  id = local.s3_bucket_name[var.environment]
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = data.aws_iam_policy_document.s3_bucket.json
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket                  = aws_s3_bucket.this.id
  ignore_public_acls      = true
  block_public_acls       = true
  restrict_public_buckets = true
  block_public_policy     = true
}

resource "aws_s3_bucket_versioning" "this" {
  bucket = aws_s3_bucket.this.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  bucket = aws_s3_bucket.this.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}