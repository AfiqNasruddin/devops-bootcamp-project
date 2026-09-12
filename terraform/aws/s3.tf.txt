module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  bucket  = "devops-bootcamp-terraform-afiq"
  versioning = { enabled = true }
  object_ownership = "BucketOwnerEnforced"
}