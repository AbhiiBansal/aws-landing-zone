# 04 - Detailed Component Design – Enterprise Landing Zone 2.0

## 1. Account Vending Mechanism

- **Trigger**: Authorized user (with delegated Control Tower permissions) requests a new account via the AWS Control Tower console in the Management account → Account Factory → "Enroll account" (or "Create account" for new root).

- **Processor**:
  - Built-in Control Tower Account Factory
  - Enhanced with Account Factory Customization (AFC) using Service Catalog portfolio/blueprints stored in a dedicated AFC hub account (to be created in build phase)
  - AFC blueprint will provision standardized baseline resources (e.g., delete default VPCs, create custom IAM roles, enable additional services)

- **Self-Service Model**:
  - Teams granted IAM permissions to access Control Tower Account Factory console (least-privilege policy attached to their SSO permission set)
  - Requester fills mandatory fields: Account name, Email (root user), OU placement (Workloads → Dev/Staging/Prod), mandatory tags (Environment, Owner, CostCenter, Project, CreatedBy)
  - No manual approval workflow in v1 (governance enforced by Tag Policy + SCPs)

- **Output** (automated in <15 minutes):
  - New member account created and enrolled in Control Tower
  - Baseline services enabled org-wide: GuardDuty, Security Hub, Config Recorder, CloudTrail organization trail
  - Account placed in correct sub-OU based on requester selection
  - Mandatory tags applied during enrollment + perpetually enforced by existing Organizations Tag Policy "EnterpriseMandatoryTags"
  - IAM Identity Center automatically assigns AdministratorAccess permission set (via default Control Tower integration)
  - New root user email receives invite; team accesses via SSO portal

- **Why console-triggered (not GitHub PR) in v1**:
  - Fully AWS-supported, zero custom pipeline maintenance
  - Meets <8–15 minute vending time reliably
  - True self-service for delegated teams without exposing Organizations APIs
  - GitOps evolution reserved for Project 4 (ArgoCD + Crossplane)

## 2. Customizations over Default Account Factory

- **Baseline provided by Control Tower default**:
  - New account created in Organizations
  - Enrolled in Control Tower (GuardDuty, Security Hub, Config Recorder, org-wide CloudTrail enabled)
  - Placed in selected OU (inherits SCPs, Tag Policies)
  - Default VPCs created in each region
  - SSO AdministratorAccess permission set assigned automatically
  - Basic tagging fields available during provisioning

- **Our v1 customizations via AFC blueprint** (to be implemented in build phase):
  - Delete default VPCs in all regions (security best practice – forces explicit networking)
  - Create standardized logging bucket + CloudTrail + Config delivery
  - Enable additional security services (e.g., Macie if required later)
  - Apply additional mandatory tags if not covered by Tag Policy
  - Create baseline IAM roles for break-glass and CI/CD access
  - No custom VPC/subnets in v1 (out of scope per requirements)

- **Limitations accepted for v1**:
  - Single blueprint per account (AFC restriction)
  - Console-only provisioning (no API or Git trigger)
  - CloudFormation or Terraform blueprint stored in Service Catalog hub account

- **Future evolution**:
  - Project 4: Replace with ArgoCD + Crossplane for true GitOps declarative account management

## 3. Mandatory Tagging Enforcement

- **Primary Mechanism**: AWS Organizations Tag Policy "EnterpriseMandatoryTags" (already attached to Root OU)
  - Enforces 5 mandatory tag keys org-wide: Environment, Owner, CostCenter, Project, CreatedBy
  - Allowed values restricted for Environment (Dev, Staging, Prod only)
  - Other keys allow any non-empty string
  - Policy type: Tag Policy (preventive – blocks non-compliant resource creation)

- **Secondary Mechanism**: Account Factory provisioning parameters
  - Requester must provide values for all mandatory tags during console-based account creation/enrollment
  - Tags applied automatically at account creation time

- **Enforcement Guarantee**:
  - Tag Policy prevents drift – resources without mandatory tags cannot be created
  - Control Tower proactive controls monitor compliance
  - No additional Terraform needed for tagging in v1 (handled natively)

- **Why this meets requirements**:
  - Tags automatically applied and cannot be removed
  - Proves compliance in interview demo (create resource without tag → denied)

## 4. OIDC Integration Details

- **Purpose in v1**: OIDC is used exclusively for future CI/CD pipelines (e.g., Terraform applies in member accounts, blueprint updates). Not used for account vending trigger (console-based).

- **Existing Components (already live)**:
  - OIDC Provider: token.actions.githubusercontent.com (in Management account 311472845767)
  - IAM Role: GitHubActionsRole
    - Trust policy restricted to repo:AbhiiBansal/aws-landing-zone:* (least privilege)
    - Current permissions: S3 + DynamoDB access to remote state bucket/table (awslz-terraform-state, awslz-terraform-locks)

- **v1 Usage**:
  - GitHub Actions workflows in the monorepo assume this role for safe Terraform operations (plan/apply) in browser-only Codespaces or runners
  - Proves zero long-term credentials (no access keys ever created)

- **Extensions Planned**:
  - Add permissions for Service Catalog blueprint updates (when we build AFC)
  - Add scoped permissions for member account operations in later projects
  - No changes required for account vending itself

- **Success Demo**:
  - Show green GitHub Actions run assuming role + `aws sts get-caller-identity`
  - Prove no access keys: IAM → Users → (no root/user with keys) + `aws iam list-access-keys` returns empty

## 5. Remote State Management

- **Backend Configuration**:
  - S3 bucket: awslz-terraform-state (in Management account 311472845767, region ap-south-1)
    - Versioning enabled
    - Default SSE-S3 encryption
  - DynamoDB table: awslz-terraform-locks (same account/region)
    - Partition key: LockID (String)

- **Purpose**:
  - Centralised, secure storage for Terraform state across all projects and accounts
  - State locking to prevent concurrent applies
  - Versioned history for recovery

- **Usage in v1**:
  - Minimal Terraform code required (only for AFC blueprint management and potential future updates)
  - All Terraform operations (plan/apply) run via GitHub Actions or Codespaces assuming GitHubActionsRole (which already has required S3 + DynamoDB permissions)
  - Backend configured in shared terraform-modules/backend.tf (to be reused)

- **Security**:
  - Bucket policy restricts access to Management account only
  - No public access, MFA delete optional in future

## 6. Module Structure Plan

- **Overall Philosophy**: 100% modular, reusable across all 5 projects. No duplicate code.

- **Shared Modules Location**: ../terraform-modules/ (sibling folder to project folders)

- **Planned Shared Modules** (to be created progressively):
  - backend: Configures S3 + DynamoDB remote state (reused everywhere)
  - organizations-baseline: Manages Tag Policies, SCP attachments, OU structure (already partially live)
  - sso-permission-sets: Defines custom permission sets and account assignments
  - service-catalog-blueprint: Deploys and versions AFC blueprints (CloudFormation or Terraform format)

- **v1 Project-Specific Terraform** (in 01-Enterprise-Landing-Zone-2.0/terraform/):
  - Minimal root module only
  - Calls shared modules for any required updates (e.g., additional SCPs, permission sets)
  - Primary Terraform usage: Deploy and update the AFC Service Catalog portfolio + blueprint in the AFC hub account

- **Structure Example**:
01-Enterprise-Landing-Zone-2.0/terraform/
├── main.tf          # Calls shared modules
├── versions.tf      # Terraform + provider versions
├── backend.tf       # Points to central remote state
└── variables.tf     # Minimal inputs

- **Why minimal Terraform in v1**:
- Control Tower + AFC handle 95% of the landing zone
- Avoids reinventing native features
- Keeps cost and complexity near zero

## 7. Risks & Mitigations

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Console-only trigger limits full self-service for non-admin teams | Medium | Medium | Delegate Control Tower Account Factory permissions via SSO permission sets (least privilege); document process clearly |
| AFC blueprint failure during vending (e.g., template error) | Low | High | Test blueprint thoroughly in a sandbox account first; use idempotent resources; monitor provisioned product status |
| Single blueprint limitation (one per account) restricts complex baselines | Low | Medium | Keep v1 blueprint simple (focus on defaults deletion + basic roles); evolve to more advanced frameworks in later projects |
| Tag Policy non-compliance blocking resource creation | Low | Low | Educate teams on mandatory tags; proactive controls alert on drift |
| OIDC role permission creep over time | Medium | High | Review and scope permissions strictly per project; use GitHub repo restriction in trust policy |
| Monthly cost exceeding $5 (unlikely) | Very Low | Low | Monitor with AWS Budgets; all resources are low/no-cost in v1 |

## 8. Next Phases
- Build: Set up AFC hub account + create first blueprint (CloudFormation for default VPC deletion + baseline roles)
- Test: Vend a test account via console + verify governance (tags, SCP inheritance, SSO access, no default VPCs)
- Deploy: Document process for teams + demo live in interview

Prepared by: [Your Name] – Principal AWS Solutions Architect
Date: 19 December 2025