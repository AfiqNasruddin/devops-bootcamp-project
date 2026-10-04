variable "region" {
  description = "AWS region used by LocalStack"
  type        = string
  default     = "ap-southeast-1"
}

variable "az" {
  description = "Availability Zone for all subnets"
  type        = string
  default     = "ap-southeast-1a"
}

variable "localstack_endpoint" {
  description = "Base endpoint for the LocalStack AWS APIs"
  type        = string
  default     = "http://localhost:4566"
}

variable "localstack_access_key" {
  description = "Access key used by LocalStack"
  type        = string
  default     = "test"
}

variable "localstack_secret_key" {
  description = "Secret key used by LocalStack"
  type        = string
  default     = "test"
}

variable "cidr_block_my_vpc" {
  description = "CIDR block für my_vpc"
  type        = string
  default     = "10.0.0.0/24"
}

variable "subnet_cidr_block_public" {
  description = "CIDR block für public subnet"
  type        = string
  default     = "10.0.0.0/25"
}

variable "subnet_cidr_block_private" {
  description = "CIDR block für private subnet"
  type        = string
  default     = "10.0.0.128/25"
}

variable "subnet_cidr" {
  description = "CIDR block allowed to access private instances"
  type        = string
  default     = "10.0.0.0/24"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "ami_id" {
  description = "AMI ID registered in LocalStack for EC2 instances"
  type        = string
  default     = "ami-1e749f67"
}

variable "iam_instance_profile_name" {
  description = "Name of the IAM instance profile used by EC2 instances"
  type        = string
  default     = "EC2-SSM-Role-devops"
}
