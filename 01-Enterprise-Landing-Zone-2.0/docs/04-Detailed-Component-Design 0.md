# Phase 4 – Detailed Component Design (LLD)

| Component                        | Exact AWS Service / Setting                        | Configuration Details                                      | Why we chose this service (interview answer) | Why this column is here (you explain in interview) |
|----------------------------------|----------------------------------------------------|------------------------------------------------------------|-----------------------------------------------|-----------------------------------------------------|
| Remote Terraform State           | S3 bucket + DynamoDB in Management account        | Bucket: awslz-terraform-state (versioned + encrypted)      | Central, secure, encrypted – never in workload accounts | Shows you understand state security & drift prevention |
| State Locking                    | DynamoDB table                                     | Table: awslz-terraform-locks (LockID = Primary Key)        | Prevents two runs at once → no corruption     | Proves you’ve seen real disasters from missing locking |
| OIDC Provider                    | IAM OIDC Identity Provider                         | URL: token.actions.githubusercontent.com                   | Zero long-term keys – mandatory in big companies | Shows zero-trust thinking (keys = banned) |
| GitHub Actions Role              | IAM Role in Management account                     | Name: GitHubActionsRole, trust policy with OIDC            | Only GitHub can assume it – least privilege  | Demonstrates OIDC is the only way in 2025+ |
| Account Factory Blueprint        | Control Tower Account Factory customisation        | Custom JSON with mandatory tags + baseline                 | Every account born perfect – no manual fixes  | Proves you automate governance at birth |
| Mandatory Tags Policy            | AWS Organizations Tag Policy                       | Tags: Environment, Owner, CostCenter, Project, CreatedBy   | Cannot be removed – required for cost allocation & audit | Shows you think like Finance + Security teams |
| SCP for Workloads OU             | Service Control Policy                             | Deny root actions, deny disabling GuardDuty, deny public S3| Extra safety for Prod – RBI/PCI requirement   | Proves you know how to lock down production |
| IAM Identity Center (SSO)        | IAM Identity Center                                | Default directory + MFA enforced + AdministratorAccess     | One login for all accounts – no root, no keys | Shows you follow AWS Well-Architected Security pillar |

Prepared by: AwsLZ Architect | Date: 21 Nov 2025

# 04 – Detailed Component Design (LLD) – FINAL PRODUCTION VERSION (27 Nov 2025)

| # | What we need                              | Exact AWS Service + Name we created                          | Configuration Details                                               | Why this wins every interview (say this exact line)                                      |
|---|-------------------------------------------|--------------------------------------------------------------|---------------------------------------------------------------------|------------------------------------------------------------------------------------------|
| 1 | Save Terraform state safely + encrypted   | S3 bucket → awslz-terraform-state                           | Versioned, SSE-S3 + Bucket Key, in Management account               | "State is the single source of truth – encrypted & locked in Management account only"   |
| 2 | Prevent two runs breaking state           | DynamoDB → awslz-terraform-locks                            | LockID = Primary Key, in Management account                         | "DynamoDB locking prevents corruption – I’ve seen real disasters without it"            |
| 3 | No long-term access keys anywhere         | IAM OIDC Provider → token.actions.githubusercontent.com     | Audience = sts.amazonaws.com                                        | "Access keys banned in every big company – OIDC is 2025+ standard"                       |
| 4 | Only GitHub can assume AWS roles          | IAM Role → GitHubActionsRole                                | Trust policy with OIDC + your GitHub username                       | "Least privilege – only our repo can assume it, nothing else"                           |
| 5 | New accounts born perfect                 | AWS Organizations Tag Policy → EnterpriseMandatoryTags      | Attached to Root – 5 mandatory keys (Environment restricted)       | "Automation at birth via Tag Policy – no manual fixes ever"                              |
| 6 | Force tags on every resource              | Same Tag Policy above                                       | Environment = Dev/Staging/Prod, Owner/CostCenter/Project/CreatedBy | "Finance & Security love it – enforced on all resources, cannot be removed"             |
| 7 | Extra Prod lockdown                       | SCP → Workloads-Prod-Lockdown                               | Attached to Workloads OU – deny root, deny public S3, deny disabling GuardDuty/SecurityHub | "RBI/PCI requirement – root banned, security services immutable"                         |
| 8 | One login for all accounts                | IAM Identity Center (SSO)                                   | Already active + MFA enforced                                       | "No root, no keys – AWS Well-Architected Security pillar"                                |

**One-sentence interview killer:**  
“Terraform state locked in Management, OIDC zero keys, Tag Policy on Root forces 5 mandatory tags at birth, SCP locks Prod like a bank – exactly how Amazon, Paytm, and Goldman Sachs do it.”

Prepared by: Real 85 LPA+ Architect | Date: 27 Nov 2025