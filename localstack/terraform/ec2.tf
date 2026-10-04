resource "aws_instance" "webserver" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  private_ip                  = "10.0.0.5"
  subnet_id                   = module.my_vpc.public_subnets[0]
  associate_public_ip_address = true
  vpc_security_group_ids      = [module.public_sg.id]
  iam_instance_profile        = aws_iam_instance_profile.ec2.name

  tags = {
    Name = "webserver"
  }
}

resource "aws_instance" "mon" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  private_ip             = "10.0.0.136"
  subnet_id              = module.my_vpc.private_subnets[0]
  vpc_security_group_ids = [module.private_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2.name

  tags = {
    Name = "mon"
  }
}

resource "aws_instance" "ctrl" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  private_ip             = "10.0.0.135"
  subnet_id              = module.my_vpc.private_subnets[0]
  vpc_security_group_ids = [module.private_sg.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2.name

  tags = {
    Name = "ctrl"
  }
}
