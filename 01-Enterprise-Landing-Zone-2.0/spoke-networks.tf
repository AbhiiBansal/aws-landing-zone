# -----------------------------------------------------------------------
# PHASE 4: SPOKE NETWORKS
# -----------------------------------------------------------------------
# This file creates the VPCs in the Dev and Prod accounts.
# Notice how we use 'providers = { aws = aws.alias }' to switch accounts.

# 1. DEVELOPMENT VPC
module "dev_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  providers = {
    aws = aws.dev
  }

  name = "dev-vpc"
  cidr = "10.1.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24"]

  # Cost Saving for Dev: Single NAT Gateway is enough
  enable_nat_gateway = true
  single_nat_gateway = true

  tags = {
    Environment = "Development"
    Role        = "Spoke-VPC"
  }
}

# 2. PRODUCTION VPC
module "prod_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  providers = {
    aws = aws.prod
  }

  name = "prod-vpc"
  cidr = "10.2.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
  public_subnets  = ["10.2.101.0/24", "10.2.102.0/24"]

  # High Availability for Prod: One NAT Gateway per AZ
  enable_nat_gateway = true
  single_nat_gateway = false 
  one_nat_gateway_per_az = true

  tags = {
    Environment = "Production"
    Role        = "Spoke-VPC"
  }
}