data "aws_iam_policy_document" "ec2_assume" {
  statement {
    actions = ["sts:AssumeRole"]
    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ssm" {
  name               = var.iam_role_name
  assume_role_policy = data.aws_iam_policy_document.ec2_assume.json
}

resource "aws_iam_role_policy" "ssm" {
  name = "ssm-mock"
  role = aws_iam_role.ssm.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["ssm:*", "ssmmessages:*", "ec2messages:*"]
      Resource = "*"
    }]
  })
}

resource "aws_iam_instance_profile" "ssm" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.ssm.name
}
