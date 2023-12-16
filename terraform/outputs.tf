output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.this.id
  description = "Cloudfront distribution ID string."
}

output "s3_bucket_id" {
  value       = aws_s3_bucket.this.id
  description = "S3 bucket id string."
}