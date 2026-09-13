data "aws_ami" "my_ami" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }
}

data "aws_iam_instance_profile" "my_ssm_profile" {
  name = "EC2-SSM-Role-devops"
}

module "webserver" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 6.0"
  name                   = "webserver"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = var.instance_type
  private_ip             = "10.0.0.5"
  create_eip             = true
  subnet_id              = module.my_vpc.public_subnets[0]
  create_security_group  = false
  vpc_security_group_ids = [module.public_sg.id]
  key_name               = "afiq"
  tags                   = { Name = "webserver" }
  iam_instance_profile   = data.aws_iam_instance_profile.my_ssm_profile.name
}

module "mon" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 6.0"
  name                   = "mon"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = var.instance_type
  subnet_id              = module.my_vpc.private_subnets[0]
  create_security_group  = false
  private_ip             = "10.0.0.136"
  vpc_security_group_ids = [module.private_sg.id]
  key_name               = "afiq"
  tags                   = { Name = "mon" }
  iam_instance_profile   = data.aws_iam_instance_profile.my_ssm_profile.name
}

module "ctrl" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 6.0"
  name                   = "ctrl"
  ami                    = data.aws_ami.my_ami.id
  instance_type          = var.instance_type
  subnet_id              = module.my_vpc.private_subnets[0]
  create_security_group  = false
  private_ip             = "10.0.0.135"
  vpc_security_group_ids = [module.private_sg.id]
  key_name               = "afiq"
  tags                   = { Name = "ctrl" }
  iam_instance_profile   = data.aws_iam_instance_profile.my_ssm_profile.name
}