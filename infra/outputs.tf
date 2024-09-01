output "s3_bucket_id" {
  description = "S3 bucket id string."
  value       = aws_s3_bucket.this.id
}