# Phase 0 & Deliverables – Exact Original (8 steps)

| Step | What a real architect does | Why | File |
|------|----------------------------|-----|------|
| 1    | Write Requirements + Success Criteria | No budget without this | 01-requirements.md (DONE) |
| 2    | High-Level Architecture Diagram (HLD) | Must be approved | landing-zone-2.0.drawio (DONE) |
| 3    | Multi-Account Strategy & Landing Zone Mapping | Real account mapping | 03-Multi-Account-Strategy-Bridge.md (DONE) |
| 4    | Detailed Component Design | Deep technical choices | 04-Detailed-Component-Design.md (next) |
| 5    | Cost Estimate (under 0 total) | Management always asks | In README |
| 6    | Terraform Module Structure + State Management | Remote backend, locking | terraform/ folder |
| 7    | CI/CD Pipeline Design | GitHub Actions + OIDC | .github/workflows/ |
| 8    | Only then write first line of code | Never code first | After all above |

Deliverables (final repo):
1. 01-requirements.md
2. landing-zone-2.0.drawio
3. 03-Multi-Account-Strategy-Bridge.md
4. 04-Detailed-Component-Design.md
5. Terraform code (100% modular)
6. Custom Account Factory blueprints
7. OIDC trust (no keys)
8. Automated SCP + tagging
9. Remote state + locking
10. Full README + cost table

Current: 1–3 + 5 DONE | Next: Phase 4

Prepared by: Abhinav – Solution Architect | 21 Nov 2025
