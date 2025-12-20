# How I (100 LPA+ Principal Architect) Decide Services – Exact 5-Question Checklist

| # | Question I ask myself                          | What I asked for this project                              | Answer that forced the service |
|---|------------------------------------------------|------------------------------------------------------------|--------------------------------|
| 1 | What is the #1 business pain we are solving?   | Manual account creation + people making access keys        | Must be self-service + zero long-term keys → OIDC + Account Factory |
| 2 | What is AWS’s official recommended pattern?    | Looked up AWS Well-Architected + Control Tower docs        | Control Tower is literally built for this → use it |
| 3 | What are the top 3 security risks if we do it wrong? | 1. Keys leaked  2. No guardrails  3. Human error          | 1 → OIDC only  2 → Control Tower guardrails  3 → Full automation |
| 4 | What is the simplest thing that meets 95% of enterprise needs? | 95% of companies want multi-account + SSO + no keys + guardrails | Control Tower + IAM Identity Center + OIDC + GitHub Actions |
| 5 | What will the interviewer/CTO ask in first 2 minutes? | “How do you prevent access keys?” “How fast?” “How tags?” | Diagram must answer all three instantly → OIDC label, <8 min label, tag box |

# Actual Decision Table – Why We Chose Each Service

| Requirement                  | Possible AWS ways                              | Service I chose                 | Real company reason (why this wins)                     |
|------------------------------|------------------------------------------------|---------------------------------|---------------------------------------------------------|
| Self-service account creation| Manual console, Organizations API, Account Factory | Control Tower Account Factory  | Official AWS enterprise pattern + auto guardrails       |
| Zero long-term credentials   | Access keys, SSO, OIDC                         | OIDC from GitHub Actions       | Access keys are banned in every big company             |
| Automatic governance         | Manual Config rules, Control Tower guardrails  | Control Tower guardrails       | Applied instantly to every new account – zero drift     |
| Central SSO login            | Root users, IAM users, IAM Identity Center     | IAM Identity Center            | One login for all accounts – mandatory for 50 LPA+      |
| Mandatory tags               | Manual tagging, Tag policies                   | Tag policies + Account Factory | Enforced at creation – cannot be removed                |
| Central logging & audit      | Per-account CloudTrail, Organization Trail     | Organization Trail → LogArchive| Immutable central logs – required for RBI/PCI compliance|


