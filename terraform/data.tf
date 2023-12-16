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

  flat_records = [for key, val in local.route53_records[var.environment] : val]
  flat_aliases = [for key, val in local.route53_records[var.environment] : val if key != root]

  s3_bucket_name = {
    prod = "weordl.com"
    beta = "beta.weordl.com"
  }

  s3_origin_id = "${local.s3_bucket_name[var.environment]}-origin"
}