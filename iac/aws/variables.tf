variable "az" {
  description = "Availability Zone untuk semua subnet"
  type        = string
  default     = "ap-southeast-1a"
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
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block_public" {
  description = "CIDR block untuk subnet publik"
  type        = string
  default     = "10.0.0.0/16"
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