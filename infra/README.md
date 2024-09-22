# Weordl Infra as Code

This project defines the resources necessary to host the origin of the weordl application, in this case and AWS S3 bucket.

It is up to another project to expose this origin as desired, it is currently configured to be exposed by CloudFront.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 5.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_s3_bucket.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket) | resource |
| [aws_s3_bucket_policy.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_policy) | resource |
| [aws_s3_bucket_public_access_block.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_public_access_block) | resource |
| [aws_s3_bucket_server_side_encryption_configuration.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_server_side_encryption_configuration) | resource |
| [aws_s3_bucket_versioning.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket_versioning) | resource |
| [aws_iam_policy_document.s3_bucket](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_aws_region"></a> [aws\_region](#input\_aws\_region) | The AWS region where the main provider will be pointed to. | `string` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | The deployment stage/environment of this deploy (dev/staging/prod/etc.). | `string` | n/a | yes |
| <a name="input_project"></a> [project](#input\_project) | A name that labels this specific project within an app deploy. | `string` | n/a | yes |
| <a name="input_source_control"></a> [source\_control](#input\_source\_control) | The source control repo of this deploy. | `string` | n/a | yes |
| <a name="input_source_version"></a> [source\_version](#input\_source\_version) | Version string associated with release of this project. | `string` | n/a | yes |
| <a name="input_tf_state_bucket"></a> [tf\_state\_bucket](#input\_tf\_state\_bucket) | The s3 bucket where state is stored. | `string` | n/a | yes |
| <a name="input_tf_state_key"></a> [tf\_state\_key](#input\_tf\_state\_key) | The s3 path where state is stored. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_s3_bucket_id"></a> [s3\_bucket\_id](#output\_s3\_bucket\_id) | S3 bucket id string. |
<!-- END_TF_DOCS -->