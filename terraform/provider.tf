terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.10.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      environment    = var.environment
      project        = var.project
      sourceControl  = var.source_control
      terraformState = "${var.tf_state_bucket}/${var.tf_state_key}"
    }
  }
}