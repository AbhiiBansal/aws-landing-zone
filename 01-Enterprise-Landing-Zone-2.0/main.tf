
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

# 2. Debugging Outputs
# This will print the Account ID and Region in the logs
data "aws_caller_identity" "current" {}
data "aws_region" "current" {}

output "deployed_account_id" {
  value = data.aws_caller_identity.current.account_id
}

output "deployed_region" {
  value = data.aws_region.current.id
}# Reliability Trigger
