resource "aws_iam_role" "ec2" {
  name = var.iam_instance_profile_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_instance_profile" "ec2" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.ec2.name
}
