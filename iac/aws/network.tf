module "my_vpc"{
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 6.0"

    name = "devops-vpc"
    cidr = var.cidr_block_my_vpc
    azs = [var.az]
    public_subnets  = [var.subnet_cidr_block_public]
    private_subnets = [var.subnet_cidr_block_private]
    map_public_ip_on_launch = true
    enable_nat_gateway      = false
    single_nat_gateway      = false
    
}

