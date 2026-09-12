module "my_vpc"{
    source = "terraform-aws-modules/vpc/aws"
    version = "~> 6.0"

    name = "devops-vpc"
    cidr = "10.0.0.0/24"
    azs = var.az
    public_subnets  = ["10.0.0.0/25"]
    private_subnets = ["10.0.0.128/25"]
    map_public_ip_on_launch = true
    enable_nat_gateway      = false
    single_nat_gateway      = false
    
}

