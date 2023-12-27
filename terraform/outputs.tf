output "cloudfront_distribution_id" {
  description = "Cloudfront distribution ID string."
  value       = aws_cloudfront_distribution.this.id
}

output "s3_bucket_id" {
  description = "S3 bucket id string."
  value       = aws_s3_bucket.this.id
}