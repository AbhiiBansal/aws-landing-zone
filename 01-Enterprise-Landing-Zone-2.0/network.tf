# -----------------------------------------------------------------------
# HUB NETWORK (Zero Cost Version)
# -----------------------------------------------------------------------
# This VPC hosts the Central Networking Hub.
# In "Zero Cost" mode, we use Public Subnets for internet access.

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.1.2"
  name    = "shared-services-vpc"
  cidr    = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # --- ZERO COST CONFIGURATION ---
  enable_nat_gateway = false
  single_nat_gateway = false
  enable_vpn_gateway = false
  # -------------------------------

  # Allow instances to get Public IPs automatically (Free Internet Access)
  map_public_ip_on_launch = true

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Project     = "Enterprise-Landing-Zone"
    Environment = "Shared-Services"
    ManagedBy   = "Terraform"
  }
}