cd "01-Enterprise-Landing-Zone-2.0/docs" && \
cat > "04-Detailed-Component-Design-SUPER-SIMPLE.md" << 'EOF'
# Phase 4 – Detailed Component Design (SUPER SIMPLE – perfect for screenshot)

| What we need                     | Which AWS service we use        | What we type / name it                     | Why we chose this (interview answer) | Why this column exists (you say in interview) |
|----------------------------------|---------------------------------|--------------------------------------------|--------------------------------------|-----------------------------------------------|
| Save Terraform state safely      | S3 bucket + DynamoDB            | Bucket = awslz-terraform-state             | Locked, encrypted, never in Dev/Prod | Shows you know state = single point of failure |
| Stop two people breaking state   | DynamoDB locking                | Table = awslz-terraform-locks              | Prevents corruption                  | Proves you’ve seen real disasters             |
| No access keys anywhere          | OIDC (GitHub → AWS)             | Provider URL = token.actions.githubusercontent.com | Keys are banned in big companies     | Zero-trust proof                              |
| Only GitHub can run Terraform    | IAM Role                        | Role = GitHubActionsRole                   | Only GitHub can use it               | Least privilege                               |
| New accounts born perfect        | Account Factory custom JSON     | Custom tags + baseline                     | No manual fixes needed               | Automation at birth                           |
| Force tags on everything         | Organizations Tag Policy        | Environment, Owner, CostCenter, Project    | For billing & audit                  | Finance + Security love it                    |
| Extra Prod lockdown              | SCP (Service Control Policy)    | Deny root, deny public S3, deny turning off GuardDuty | RBI/PCI requirement                 | Shows you know real compliance               |
| One login for all accounts       | IAM Identity Center (SSO)       | SSO + MFA only                             | No root, no keys                     | AWS Well-Architected Security pillar         |

One-sentence for any interview:
“State in locked S3, OIDC so no keys, tags & guardrails forced at birth, SSO+MFA only – exactly like Amazon and banks do.”

Prepared by: AwsLZ Architect | 21 Nov 2025