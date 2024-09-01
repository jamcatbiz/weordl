locals {
  s3_bucket_name = {
    prod = "weordl.com"
    beta = "beta.weordl.com"
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
      values   = toset([aws_cloudfront_distribution.this.arn])
    }
  }
}