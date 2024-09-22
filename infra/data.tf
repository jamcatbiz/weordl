locals {
  s3_bucket_name = {
    prod = "weordl.com"
    beta = "beta.weordl.com"
  }
  cloudfront_distribution_arn = {
    prod = "arn:aws:cloudfront::784095588722:distribution/E5OECTRVHHRM6"
    beta = "arn:aws:cloudfront::784095588722:distribution/E1HSOV269YG7ND"
  }
}

data "aws_iam_policy_document" "s3_bucket" {
  statement {
    sid       = "OACAccessOnly"
    effect    = "Allow"
    actions   = toset(["s3:GetObject"])
    resources = toset(["${aws_s3_bucket.this.arn}/*"])

    principals {
      type        = "Service"
      identifiers = toset(["cloudfront.amazonaws.com"])
    }

    condition {
      test     = "StringEquals"
      variable = "AWS:SourceArn"
      values   = toset([local.cloudfront_distribution_arn[var.environment]])
    }
  }
}