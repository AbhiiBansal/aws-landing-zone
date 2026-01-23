# -----------------------------------------------------------------------
# SPOKE NETWORKS (Zero Cost Version)
# -----------------------------------------------------------------------

# 1. DEVELOPMENT VPC
module "dev_vpc" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "~> 5.0"
  providers = { aws = aws.dev }

  name = "dev-vpc"
  cidr = "10.1.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
  public_subnets  = ["10.1.101.0/24", "10.1.102.0/24"]

  # --- ZERO COST ---
  enable_nat_gateway = false
  single_nat_gateway = false
  # -----------------
  
  # Allow Public IPs for free internet access in Dev
  map_public_ip_on_launch = true

  tags = {
    Environment = "Development"
    Role        = "Spoke-VPC"
  }
}

# 2. PRODUCTION VPC
module "prod_vpc" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "~> 5.0"
  providers = { aws = aws.prod }

  name = "prod-vpc"
  cidr = "10.2.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
  public_subnets  = ["10.2.101.0/24", "10.2.102.0/24"]

  # --- ZERO COST ---
  enable_nat_gateway = false
  single_nat_gateway = false
  # -----------------
  
  map_public_ip_on_launch = true

  tags = {
    Environment = "Production"
    Role        = "Spoke-VPC"
  }
}
# 3. STAGING VPC
module "staging_vpc" {
  source    = "terraform-aws-modules/vpc/aws"
  version   = "~> 5.0"
  providers = { aws = aws.staging }

  name = "staging-vpc"
  cidr = "10.3.0.0/16" # Next available CIDR block

  azs             = ["ap-south-1a", "ap-south-1b"]
  private_subnets = ["10.3.1.0/24", "10.3.2.0/24"]
  public_subnets  = ["10.3.101.0/24", "10.3.102.0/24"]

  # Zero Cost Config
  enable_nat_gateway = false
  single_nat_gateway = false
  map_public_ip_on_launch = true

  tags = {
    Environment = "Staging"
    Role        = "Spoke-VPC"
  }
}