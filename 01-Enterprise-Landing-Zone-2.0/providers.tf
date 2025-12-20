provider "aws" {
  region = "ap-south-1"
  
  # Default tags apply to ALL resources created by this project
  default_tags {
    tags = {
      Project     = "Enterprise-Landing-Zone"
      Environment = "Production"
      ManagedBy   = "Terraform"
      Owner       = "AbhiiBansal"
    }
  }
}