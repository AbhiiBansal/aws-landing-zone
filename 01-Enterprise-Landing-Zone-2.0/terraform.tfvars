# -----------------------------------------------------------------------------
# AWS CONFIGURATION
# -----------------------------------------------------------------------------
aws_region = "ap-south-1"

# -----------------------------------------------------------------------------
# ACCOUNT IDs (Extracted from your screenshot)
# -----------------------------------------------------------------------------

# Hub Network lives in "Shared-Services"
hub_account_id  = "375896310432"

# Spoke 1 lives in "Dev"
dev_account_id  = "685386557511"

# Spoke 2 lives in "Prod"
prod_account_id = "567554448213"
# -----------------------------------------------------------------------------
# RESOURCE SHARING (Transit Gateway)
# -----------------------------------------------------------------------------
workloads_ou_arn = "arn:aws:organizations::311472845767:ou/o-lfpq3a1r1l/ou-wkdq-d1fq0ffk"
staging_account_id = "167004608070"

budget_alert_email = "abhinavbansal2018@gmail.com"