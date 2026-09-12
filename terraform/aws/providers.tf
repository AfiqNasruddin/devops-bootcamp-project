terraform {
  required_version = ">= 1.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = var.s3_bucket_name
    key          = "project/terraform.tfstate"
    region       = var.az
    use_lockfile = true
  }
}
provider "aws" {
  region = var.az
}

data "aws_caller_identity" "my_account" {}