# SRE: Network Architecture for Shared Services
# This VPC hosts shared tools (Jenkins, Gitlab, Scanners) and the Transit Gateway.

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"

  name = "shared-services-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"] # App Layer (Internal Tools)
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"] # DMZ Layer (NAT Gateways)
  database_subnets = ["10.0.201.0/24", "10.0.202.0/24"] # Data Layer (DBs)

  enable_nat_gateway = true
  single_nat_gateway = true # Cost optimization: Use 1 NAT GW shared across AZs
  enable_vpn_gateway = false

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project     = "Enterprise-Landing-Zone"
    Environment = "Shared-Services"
    ManagedBy   = "Terraform"
  }
}