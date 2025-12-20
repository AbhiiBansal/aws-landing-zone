# Phase 3 – Multi-Account Strategy (The Bridge: HLD Diagram → Real World)

Think of Phase 3 as the bridge between the pretty HLD diagram and the real world.

| Column in the table            | What it means (interview explanation)                              |
|--------------------------------|--------------------------------------------------------------------|
| Component                      | The logical piece in the diagram (e.g., “New AWS Account”)         |
| AWS Account Used               | The real AWS account that hosts this component                    |
| Account ID Example             | Actual 12-digit ID (you show this in interviews to prove it’s real)|
| OU                             | Organizational Unit – decides which guardrails/SCPs apply          |
| Purpose & Governance Applied   | What this account is for + which automatic security rules run here|

### Your real table (already created in the file)

| Component              | AWS Account Used       | Account ID Example | OU         | Purpose & Governance Applied                                      |
|------------------------|------------------------|--------------------|------------|-------------------------------------------------------------------|
| Management Account     | Aws Solution Architect | 311472845767       | Root       | Billing, SSO, OIDC role, remote state (S3 + DynamoDB)             |
| Shared Logging         | LogArchive             | 366101697201       | Security   | All CloudTrail & Config logs go here – immutable                 |
| Shared Audit           | Audit                  | 647132524009       | Security   | GuardDuty, Security Hub, Macie – central security                |
| Workloads OU           | (container)            | –                  | Workloads  | Holds all environments                                            |
| Development            | Dev                    | 685386555751       | Workloads  | Full sandbox for developers                                       |
| Staging                | Staging                | (your staging ID)  | Workloads  | Pre-production mirror of Prod                                     |
| Production             | Prod                   | (your prod ID)     | Workloads  | Locked-down production                                            |

