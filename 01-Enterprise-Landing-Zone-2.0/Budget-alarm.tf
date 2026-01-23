# -----------------------------------------------------------------------
# FINOPS: AUTOMATED BUDGET GUARD
# -----------------------------------------------------------------------
# Monitoring the Hub Account (Shared Services) for total spending.

resource "aws_budgets_budget" "zero_spend" {
  provider          = aws # Deploys to Hub
  name              = "Zero-Cost-Guardrail"
  budget_type       = "COST"
  limit_amount      = "1.00"
  limit_unit        = "USD"
  time_unit         = "MONTHLY"
  time_period_start = "2026-01-01_00:00"

  # Alert 1: Forecasted to exceed $1.00 (Early Warning)
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 100
    threshold_type             = "PERCENTAGE"
    notification_type          = "FORECASTED"
    subscriber_email_addresses = [var.budget_alert_email]
  }

  # Alert 2: Actually exceeded $0.80 (Critical Warning)
  notification {
    comparison_operator        = "GREATER_THAN"
    threshold                  = 80
    threshold_type             = "PERCENTAGE"
    notification_type          = "ACTUAL"
    subscriber_email_addresses = [var.budget_alert_email]
  }
}