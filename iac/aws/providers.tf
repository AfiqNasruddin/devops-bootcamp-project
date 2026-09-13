terraform {
  required_version = ">= 1.15"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }
  backend "s3" {
    bucket       = "devops-bootcamp-terraform-afiq"
    key          = "project/terraform.tfstate"
    region       = "ap-southeast-1a"
    use_lockfile = true
  }
}
provider "aws" {
  region = "ap-southeast-1a"
  default_tags {
    tags = {
      Project   = devops-bootcamp-final-afiq
      ManagedBy = "terraform"
    }
}
}

data "aws_caller_identity" "my_account" {}