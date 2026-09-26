variable "aws_region" {
  description = "AWS region emulated by LocalStack"
  type        = string
  default     = "ap-southeast-1"
}

variable "az" {
  description = "Availability Zone untuk semua subnet"
  type        = string
  default     = "ap-southeast-1a"
}

variable "localstack_endpoint" {
  description = "LocalStack edge endpoint"
  type        = string
  default     = "http://localhost:4566"
}

variable "ami_id" {
  description = "LocalStack AMI. Community/mock accepts any id; Pro docker AMIs include ami-df5de72bdb3b (Ubuntu 22.04)."
  type        = string
  default     = "ami-df5de72bdb3b"
}

variable "key_name" {
  description = "EC2 key pair name created in LocalStack"
  type        = string
  default     = "afiq"
}

variable "s3_bucket_name" {
  description = "Nama bucket S3 untuk menyimpan state Terraform"
  type        = string
  default     = "devops-bootcamp-terraform-afiq"
}

variable "ecr_repository_name" {
  description = "Nama repository ECR untuk menyimpan image Docker"
  type        = string
  default     = "devops-bootcamp/final-project-afiq"
}

variable "cidr_block_my_vpc" {
  description = "CIDR block untuk my_vpc"
  type        = string
  default     = "10.0.0.0/24"
}

variable "subnet_cidr_block_public" {
  description = "CIDR block untuk subnet publik"
  type        = string
  default     = "10.0.0.0/25"
}

variable "subnet_cidr_block_private" {
  description = "CIDR block untuk subnet private"
  type        = string
  default     = "10.0.0.128/25"
}

variable "subnet_cidr" {
  description = "CIDR block"
  type        = string
  default     = "10.0.0.0/24"
}

variable "instance_type" {
  description = "Jenis instance EC2"
  type        = string
  default     = "t3.micro"
}

variable "iam_role_name" {
  description = "Name of the EC2 role used by SSM"
  type        = string
  default     = "EC2-SSM-Role-devops"
}

variable "iam_instance_profile_name" {
  description = "Name of the EC2 instance profile used by SSM"
  type        = string
  default     = "EC2-SSM-Role-devops"
}
