resource "tls_private_key" "local" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "local" {
  key_name   = var.key_name
  public_key = tls_private_key.local.public_key_openssh
}

resource "local_file" "private_key" {
  filename        = "${path.module}/localstack-key.pem"
  content         = tls_private_key.local.private_key_openssh
  file_permission = "0400"
}

module "webserver" {
  source                  = "terraform-aws-modules/ec2-instance/aws"
  version                 = "~> 6.0"
  name                    = "webserver"
  ami                     = var.ami_id
  instance_type           = var.instance_type
  private_ip              = "10.0.0.11"
  create_eip              = false
  subnet_id               = module.my_vpc.public_subnets[0]
  create_security_group   = false
  vpc_security_group_ids  = [module.public_sg.id]
  key_name                = aws_key_pair.local.key_name
  tags                    = { Name = "webserver" }
  iam_instance_profile    = var.iam_instance_profile_name
}

module "mon" {
  source                  = "terraform-aws-modules/ec2-instance/aws"
  version                 = "~> 6.0"
  name                    = "mon"
  ami                     = var.ami_id
  instance_type           = var.instance_type
  private_ip              = "10.0.0.136"
  subnet_id               = module.my_vpc.private_subnets[0]
  create_security_group   = false
  vpc_security_group_ids  = [module.private_sg.id]
  key_name                = aws_key_pair.local.key_name
  tags                    = { Name = "mon" }
  iam_instance_profile    = var.iam_instance_profile_name
}

module "ctrl" {
  source                  = "terraform-aws-modules/ec2-instance/aws"
  version                 = "~> 6.0"
  name                    = "ctrl"
  ami                     = var.ami_id
  instance_type           = var.instance_type
  subnet_id               = module.my_vpc.private_subnets[0]
  create_security_group   = false
  private_ip              = "10.0.0.135"
  vpc_security_group_ids  = [module.private_sg.id]
  key_name                = aws_key_pair.local.key_name
  tags                    = { Name = "ctrl" }
  iam_instance_profile    = var.iam_instance_profile_name
}
