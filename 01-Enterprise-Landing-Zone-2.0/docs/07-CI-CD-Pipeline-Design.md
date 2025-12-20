# 07 – CI/CD Pipeline Design (GitHub + OIDC – Zero Keys) – FINAL & LIVE

| Component                        | Real Resource Created                                      | Status   | Proof / Link |
|----------------------------------|------------------------------------------------------------|----------|--------------|
| GitHub Monorepo                  | aws-solution-architect-portfolio (Private)                 | Live     | https://github.com/AbhiiBansal/aws-solution-architect-portfolio |
| OIDC Provider                    | token.actions.githubusercontent.com                        | Active   | IAM → Identity providers |
| IAM Role                         | GitHubActionsRole                                          | Active   | ARN: arn:aws:iam::311472845767:role/GitHubActionsRole |
| Trust Policy                     | Restricted to repo:AbhiiBansal/aws-solution-architect-portfolio:* | Fixed (visual editor) | Trust relationships tab |
| Inline Permissions               | S3 + DynamoDB full access to remote state                  | Added    | Permissions tab |
| GitHub Actions Workflow          | .github/workflows/oidc-test.yml                            | Live     | Green run #X |
| Remote Backend Access Test       | aws s3 ls awslz-terraform-state + DynamoDB lock table      | Success  | Workflow log |
| Zero Credentials Used            | No access keys ever created                                | Proven   | Interview killer |

**One-sentence interview answer (use this exact line):**
“I built a full monorepo with OIDC, zero keys, remote state, and a green GitHub Actions pipeline that assumes an IAM role and accesses S3 + DynamoDB – all 100% browser-only using console and GitHub web UI.”

**Next step:**  
Step 8 – First real `terraform plan` in GitHub Codespaces (safe preview in Dev account – zero prod impact).

Prepared by: Real Principal Architect  
Date: 27 November 2025