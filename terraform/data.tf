locals {
  route53_records = {
    prod = {
      root = "weordl.com"
      www  = "www.weordl.com"
    }
    beta = {
      root = "beta.weordl.com"
    }
  }

  s3_bucket_name = {
    prod = "weordl.com"
    beta = "beta.weordl.com"
  }

  s3_origin_id = "${local.s3_bucket_name[var.environment]}-origin"

  import_s3_map = {
    prod = "weordl.com"
    beta = "beta.weordl.com"
  }

  import_cloudfront_map = {
    prod = "E1XNVCUFXVVHFK"
    beta = "E323P8W3LFDGAH"
  }
}