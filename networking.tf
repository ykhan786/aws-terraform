module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "4.0.1"

  azs = local.azs

  cidr = local.vpc_cidr
  create_igw = true
  create_vpc = true
  enable_nat_gateway = true
  one_nat_gateway_per_az = true
  private_subnet_names = local.private_subnet_names
  private_subnets = local.private_subnets
  public_subnet_names = local.public_subnet_names
  public_subnets = local.public_subnets
}