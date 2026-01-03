provider "aws" {
  region = "ap-south-1"

  # SRE: Targeted Role for Shared-Services Account
  assume_role {
    role_arn = "arn:aws:iam::375896310432:role/AWSControlTowerExecution"
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