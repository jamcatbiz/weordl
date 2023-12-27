## ------------------------------------------------------------
## S3 BUCKET, ENCRYPTION, VERSIONING, POLICIES, ETC.
## This implementation uses Origin Access Control to expose bucket.
## ------------------------------------------------------------
resource "aws_s3_bucket" "this" {
  bucket = local.s3_bucket_name[var.environment]
}
import {
  to = aws_s3_bucket.this
  id = local.import_s3_map[var.environment]
}

resource "aws_s3_bucket_policy" "this" {
  bucket = aws_s3_bucket.this.id
  policy = templatefile("${path.module}/templates/s3_bucket_policy.json", {
    s3_bucket_arn               = aws_s3_bucket.this.arn
    cloudfront_distribution_arn = aws_cloudfront_distribution.this.arn
  })
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
      sse_algorithm = "aws:kms"
    }
  }
}

## ------------------------------------------------------------
## CLOUDFRONT DISTRIBUTION, ORIGINS, POLICIES, ETC.
## This implementation uses Origin Access Control to expose bucket.
## ------------------------------------------------------------
resource "aws_cloudfront_origin_access_control" "this" {
  name                              = "${var.environment}-${var.project}"
  description                       = "${var.environment} ${var.project} OAC"
  origin_access_control_origin_type = "s3"
  signing_behavior                  = "always"
  signing_protocol                  = "sigv4"
}

resource "aws_cloudfront_cache_policy" "this" {
  name        = "${var.environment}-${var.project}"
  comment     = "${var.environment} ${var.project} cache policy"
  default_ttl = 50
  max_ttl     = 100
  min_ttl     = 1
  parameters_in_cache_key_and_forwarded_to_origin {
    cookies_config {
      cookie_behavior = "none"
    }
    headers_config {
      header_behavior = "none"
    }
    query_strings_config {
      query_string_behavior = "none"
    }
  }
}

resource "aws_cloudfront_distribution" "this" {
  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"
  aliases             = keys(local.flat_aliases)
  price_class         = "PriceClass_100"

  origin {
    domain_name              = aws_s3_bucket.this.bucket_regional_domain_name
    origin_access_control_id = aws_cloudfront_origin_access_control.this.id
    origin_id                = local.s3_origin_id
  }

  default_cache_behavior {
    target_origin_id       = local.s3_origin_id
    allowed_methods        = ["GET", "HEAD"]
    cached_methods         = ["GET", "HEAD"]
    viewer_protocol_policy = "redirect-to-https"
    cache_policy_id        = aws_cloudfront_cache_policy.this.id
  }

  restrictions {
    geo_restriction {
      locations        = []
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn = var.certificate_arn
    ssl_support_method  = "sni-only"
  }

}
import {
  to = aws_cloudfront_distribution.this
  id = local.import_cloudfront_map[var.environment]
}

## ------------------------------------------------------------
## ROUTE 53
## ------------------------------------------------------------
resource "aws_route53_record" "a" {
  for_each = local.flat_records

  zone_id = var.hosted_zone_id
  name    = each.key
  type    = "A"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "aaaa" {
  for_each = local.flat_records

  zone_id = var.hosted_zone_id
  name    = each.key
  type    = "AAAA"

  alias {
    name                   = aws_cloudfront_distribution.this.domain_name
    zone_id                = aws_cloudfront_distribution.this.hosted_zone_id
    evaluate_target_health = false
  }
}