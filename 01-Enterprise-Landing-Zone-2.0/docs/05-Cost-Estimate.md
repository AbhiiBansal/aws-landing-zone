# 05 – Cost Estimate (Total < $5/month – Production Ready)

| Component                          | Estimated Monthly Cost | Notes |
|------------------------------------|------------------------|-------|
| Control Tower (baseline)           | $0                     | Included in landing zone |
| AFC hub account (if created)      | ~$1–2                  | t3.micro or similar for Service Catalog if needed; often $0 if no running resources |
| S3 state bucket + DynamoDB locks  | <$1                    | Low traffic |
| Organizations Tag Policy/SCPs     | $0                     | Free |
| OIDC + GitHub Actions             | $0                     | Free tier |
| GuardDuty, Config, CloudTrail org | ~$2–3                  | Already running org-wide |
| **Total**                         | **<$5**                | Well under budget |