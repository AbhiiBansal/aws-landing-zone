provider "aws" {
  region = "ap-south-1"
}

# 1. Verification Flag
# This proves AFC successfully ran in the new account.
resource "aws_ssm_parameter" "afc_flag" {
  name  = "/afc/status"
  type  = "String"
  value = "Provisioned via Control Tower AFC"

  tags = {
    ManagedBy = "Terraform-AFC"
    Blueprint = "01-baseline-resources"
  }
}