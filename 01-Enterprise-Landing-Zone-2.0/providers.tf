provider "aws" {
  region = "ap-south-1"

  # -----------------------------------------------------------
  # DEFAULT PROVIDER: Shared Services Account (The Hub)
  # -----------------------------------------------------------
  assume_role {
    role_arn = "arn:aws:iam::375896310432:role/AWSControlTowerExecution"
  }

  default_tags {
    tags = {
      Project     = "Enterprise-Landing-Zone"
      Environment = "Shared-Services"
      ManagedBy   = "Terraform"
      Owner       = "AbhiiBansal"
    }
  }
}

# -----------------------------------------------------------
# ALIAS PROVIDER: Dev Account (The Spoke)
# -----------------------------------------------------------
provider "aws" {
  alias  = "dev"
  region = "ap-south-1"

  assume_role {
    role_arn = "arn:aws:iam::685386557511:role/AWSControlTowerExecution"
  }

  default_tags {
    tags = {
      Project     = "Enterprise-Landing-Zone"
      Environment = "Development"
      ManagedBy   = "Terraform"
      Owner       = "AbhiiBansal"
    }
  }
}

# -----------------------------------------------------------
# ALIAS PROVIDER: Prod Account (The Spoke)
# -----------------------------------------------------------
provider "aws" {
  alias  = "prod"
  region = "ap-south-1"

  assume_role {
    role_arn = "arn:aws:iam::567554448213:role/AWSControlTowerExecution"
  }

  default_tags {
    tags = {
      Project     = "Enterprise-Landing-Zone"
      Environment = "Production"
      ManagedBy   = "Terraform"
      Owner       = "AbhiiBansal"
    }
  }
}