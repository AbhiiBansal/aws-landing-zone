# providers.tf

# 1. The Hub Account (Shared Services) - Default Provider
provider "aws" {
  region = var.aws_region
  
  # CRITICAL: Force Terraform to target the Shared-Services account
  # even if you are logged into Management.
  assume_role {
    role_arn = "arn:aws:iam::${var.hub_account_id}:role/AWSControlTowerExecution"
  }
}

# 2. The Dev Account (Spoke 1)
provider "aws" {
  alias  = "dev"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::${var.dev_account_id}:role/AWSControlTowerExecution"
  }
}

# 3. The Prod Account (Spoke 2)
provider "aws" {
  alias  = "prod"
  region = var.aws_region

  assume_role {
    role_arn = "arn:aws:iam::${var.prod_account_id}:role/AWSControlTowerExecution"
  }
}
# 4. The Staging Account (Spoke 3)
provider "aws" {
  alias  = "staging"
  region = var.aws_region
  assume_role {
    role_arn = "arn:aws:iam::${var.staging_account_id}:role/AWSControlTowerExecution"
  }
}