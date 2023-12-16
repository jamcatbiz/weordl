variable "aws_region" {
  type        = string
  description = "The AWS region where the main provider will be pointed to."
}
variable "environment" {
  type        = string
  description = "The deployment stage/environment of this deploy (dev/staging/prod/etc.)."
}
variable "project" {
  type        = string
  description = "A name that labels this specific project within an app deploy."
}
variable "tf_state_bucket" {
  type        = string
  description = "The s3 bucket where state is stored."
}
variable "tf_state_key" {
  type        = string
  description = "The s3 path where state is stored."
}
variable "source_control" {
  type        = string
  description = "The source control repo of this deploy."
}
variable "hosted_zone_id" {
  type        = string
  description = "The AWS Route53 hosted zone where records should be created."
}
variable "certificate_arn" {
  type        = string
  description = "The AWS ACM certificate arn for SLL on the cloudfront."
}