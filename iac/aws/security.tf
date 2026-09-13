module "public_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name            = "devops-public-sg"
  use_name_prefix = false
  vpc_id          = module.my_vpc.vpc_id


  ingress_rules = {
    http = {
      cidr_ipv4   = "10.0.0.136/32"
      cidr_ipv6   = false
      prefix_list_id = false
      reference_security_group_id = false
      ip_protocol = "tcp"
      from_port   = 9100
      to_port     = 9100
    }
    ssh = {
      cidr_ipv4   = var.subnet_cidr
      cidr_ipv6   = false
      prefix_list_id = false
      reference_security_group_id = false
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
  }
  
  egress_rules = {
    all = { cidr_ipv4 = "0.0.0.0/0", ip_protocol = "-1" }
  }
  tags = { Name = "devops-public-sg" }
}
}
module "private_sg" {
  source  = "terraform-aws-modules/security-group/aws"
  version = "~> 6.0"

  name            = "devops-private-sg"
  use_name_prefix = false
  vpc_id          = module.my_vpc.vpc_id

  ingress_rules = {
    ssh = {
      cidr_ipv4   = var.subnet_cidr
      cidr_ipv6   = false
      prefix_list_id = false
      reference_security_group_id = false
      ip_protocol = "tcp"
      from_port   = 22
      to_port     = 22
  }
  
  egress_rules = {
    all = { cidr_ipv4 = "0.0.0.0/0", ip_protocol = "-1" }
  }
  tags = { Name = "devops-private-sg" }
}
}
