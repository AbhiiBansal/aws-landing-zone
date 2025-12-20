AWS NON-SERVICE CHEAT SHEET – POLICIES, SECURITY, PERMISSIONS & BEST PRACTICES
(Lifetime A-to-Z – 2025 India market – from Associate to Principal Architect)

Golden Rule:
Never give “full access” – always least privilege.
Never use access keys – always OIDC / SSO / Roles.
Always test in Dev first.


1. IAM & Permissions Framework (3 Options)

| Requirement           | Option 1 – GOOD (MVP / Startup)    | Option 2 – BETTER (Growing Company)           | Option 3 – BEST (Bank / RBI/PCI)                     | Trade-offs (Cost          | Time                  | Risk                  | Scalability)      | Recommended When |
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| User Login            | Root + MFA only (no users)         | IAM Identity Center (SSO) + Permission Sets   | IAM Identity Center + External IdP (Okta/Azure AD)   | Cost: Free → $            | Time: 1 day → 1 week  | Risk: High → Low      | Scale: Low → High | RBI/PCI |
| GitHub / CI/CD Access | Access Keys (never do this)        | OIDC + Role (one repo)                        | OIDC + Role + Branch protection + Approval workflow  | Cost: Free                | Time: 10 min → 1 day  | Risk: High → Very Low | Scale: High       | Any production |
| Cross-Account Access  | Manual assume-role                 | OrganizationAccountAccessRole (Control Tower) | Dedicated cross-account roles + PrivateLink          | Cost: Free                | Time: Fast → Medium   | Risk: Medium → Low    | Scale: High       | Multi-account |
| Admin Permissions     | AdministratorAccess managed policy | Custom policy with only needed actions        | Permission sets + SCP guardrails                     | Cost: Free                | Time: Fast → Medium   | Risk: High → Low      | Scale: High       | Compliance |
| Secrets Management    | Parameter Store (Standard)         | Parameter Store (SecureString) + KMS          | Secrets Manager + rotation + KMS CMK                 | Cost: Free → $0.40/secret | Time: Fast → Medium   | Risk: Medium → Low    | Scale: High       | Banking |


2. Security Rules & Policies Framework (3 Options)

Requirement                  1 – GOODOption                     2 – BETTEROption                                3 – BEST                                                 Trade-offs             Recommended When
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Tag Enforcement              Manualtagging                      Tag Policy on Root (mandatory keys)             Tag Policy + Config Rule + Lambda auto-remediation       Cost: Free             Time: Fast → Medium
Deny Dangerous Actions       No SCP                             SCP on Workloads OU (deny root, public S3)      Full deny list SCP + GuardDuty + Detective               Cost: Free             Time: Fast → Medium
Public Exposure Block        Manual bucket settings             S3 Public Access Block (account level)          S3 Public Access Block (org level) + CloudFront OAC      Cost: Free             Time: Fast
Encryption                   Default SSE-S3                     SSE-KMS with AWS-managed key                    Customer-managed KMS key + rotation                      Cost: Free → $1/key    Time: Fast → Medium
Logging & Audit              CloudTrail (management account)    CloudTrail Org                                  CloudTrail Org + GuardDuty + Security Hub + Macie        Cost: Free → $500+     Time: Fast → Medium


3. Permission & Policy Best Practices (A-to-Z Lifetime Rules)

Category                        Rule                                    How to Implement (Console)                                Why (Interview Line)
-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Least Privilege                 Never use:*                             IAM → Policies → Visual editor → specific actions only    “Full access is a red flag in every audit”
No Long-Term Keys               Delete all access keys                  IAM → Users → Security credentials → Delete“              Keys get leaked – OIDC/SSO is the only way”
Role Over User                  Use roles for everything                Create role instead of user                               “Roles = temporary credentials = safer”
MFA Everywhere                  Enforce MFA for root & admins           IAM → Dashboard → Activate MFA                            “MFA is mandatory for RBI/PCI”
Password Policy                 Strong passwords                        IAM → Account settings → Password policy                  “Prevents brute-force”
Service Control Policies (SCP)  Deny list approach                      Organizations → Policies → SCP → Deny dangerous actions   “SCP is the only way to enforce org-wide”
Tag Policies                    Mandatory keys on Root                  Organizations → Tag policies → Visual editor              “No resource without tags = finance loves it”
Bucket Policies                 Deny non-SSL, deny public               S3 → Bucket → Permissions → Bucket policy                 “Blocks common misconfigs”
KMS Keys                        Customer-managed for sensitive data     KMS → Customer managed keys                               “Full control + audit”
Secrets Manager Rotation        Auto-rotate DB passwords                Secrets Manager → Rotation                                “No stale credentials”


4. Quick Decision Cheat Sheet (Pick in 10 seconds)

Client Says             Compliance?         Budget?     Timeline?       Team Skill?         Recommended Option
-----------------------------------------------------------------------------------------------------------------
“Fast MVP”              No                  Tight       <1 month        New to cloud        GOOD
“Growing startup”       No                  Medium      3 months        Some experience     BETTER
“Fintech / Bank”        RBI/PCI             Medium      6 months        Experienced         BEST
“Global bank”           RBI/PCI + Global    High        12 months       Kubernetes pros     BEST


Your interview closing line

“I always follow 
least privilege, 
zero keys, 
tag/SCP enforcement, 
and give 3 options with trade-offs – because security is not optional, it’s the foundation.”