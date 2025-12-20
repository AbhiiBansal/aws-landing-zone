# Project 01 – Enterprise Landing Zone 2.0

## Business Objective
Enable any team in the company to request and receive a fully-governed AWS account in under 8 minutes using self-service – with zero long-term credentials.

## Functional Requirements
- Self-service account vending via GitHub Pull Request (no manual console work)
- Automatic placement in correct OU (Workloads or Security)
- Mandatory tags automatically applied and enforced:
  - Environment (Dev/Staging/Prod)
  - Owner (email)
  - CostCenter
  - Project
  - CreatedBy
  - CreatedDate
- Automatic enabling of GuardDuty, Security Hub, Config Recorder, CloudTrail org-wide
- OIDC federation from GitHub Actions (no AWS access keys ever created)

## Non-Functional Requirements
- 100% Infrastructure as Code using Terraform (modular + reusable)
- Remote state + locking in Management account (S3 bucket + DynamoDB table)
- All changes go through GitHub PR + mandatory approval
- Total monthly cost < $5
- Fully reproducible in any AWS organization

## Success Criteria (you must be able to demo this live in interview)
1. Create a JSON request file → open PR → merge → new account appears in < 8 minutes
2. Log in via SSO portal → new account is visible with full AdministratorAccess
3. No access keys exist anywhere (prove with `aws iam list-access-keys`)
4. All mandatory tags are present and cannot be removed
5. Run `terraform plan` in any account → zero drift

## Out of Scope for v1
- Custom VPC or networking
- Advanced billing alerts per account
- Custom IAM policies beyond AdministratorAccess

Prepared by: Abhinav Bansal – Solution Architect
Date: 21 November 2025