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