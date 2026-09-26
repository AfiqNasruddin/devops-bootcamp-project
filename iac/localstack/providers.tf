terraform {
  required_version = ">= 1.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.9"
    }
    tls = {
      source  = "hashicorp/tls"
      version = "~> 4.0"
    }
  }
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region                      = var.aws_region
  access_key                  = "test"
  secret_key                  = "test"
  s3_use_path_style           = true
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = false
  skip_region_validation      = true

  endpoints {
    apigateway     = var.localstack_endpoint
    apigatewayv2   = var.localstack_endpoint
    cloudformation = var.localstack_endpoint
    cloudwatch     = var.localstack_endpoint
    ec2            = var.localstack_endpoint
    ecr            = var.localstack_endpoint
    iam            = var.localstack_endpoint
    kms            = var.localstack_endpoint
    lambda         = var.localstack_endpoint
    logs           = var.localstack_endpoint
    s3             = "http://s3.localhost.localstack.cloud:4566"
    s3control      = "http://s3-control.localhost.localstack.cloud:4566"
    sns            = var.localstack_endpoint
    sqs            = var.localstack_endpoint
    ssm            = var.localstack_endpoint
    sts            = var.localstack_endpoint
  }

  default_tags {
    tags = {
      Project   = "devops-bootcamp-final-afiq"
      ManagedBy = "terraform"
      Env       = "localstack"
    }
  }
}

data "aws_caller_identity" "my_account" {}
