THE ULTIMATE AWS A-to-Z CHEAT SHEET
From 8 LPA Entry-Level → 120+ LPA Principal Architect



(Real-world, 2025-2026 India market version – what actually gets you hired/promoted)

Level	                        Salary Range (India)	What you MUST own live (proof)	            Core Services + Golden Combinations	                                                                                    Interview Killer Phrase
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
L1 – Fresher / Associate	    6–15 LPA	            Free-tier playground	                    VPC, EC2, S3, IAM basics, RDS	                                                                                        “I can build a 3-tier app on AWS”
L2 – Associate (1–3 YOE)	    15–35 LPA	            Multi-account + Terraform	                Control Tower / Organizations, Landing Zone, Terraform remote state, IAM Identity Center (SSO)	                        “I built a real multi-account landing zone with zero keys”
L3 – Senior / Specialist	    35–65 LPA	            Security + Networking mastery	            GuardDuty, Security Hub, Macie, WAF, Shield, Transit Gateway, PrivateLink, KMS, Secrets Manager	                        “My landing zone is RBI/PCI compliant out of the box”
L4 – Lead / Architect	        65–100 LPA	            Full CI/CD + GitOps + Observability	        OIDC + GitHub Actions, ArgoCD/Flux, Crossplane, EKS/IRSA, CloudWatch + X-Ray + Prometheus/Grafana, EventBridge	        “Everything is GitOps, zero keys, full observability”
L5 – Principal / Distinguished	100–200+ LPA	        Multi-Region, Zero-Trust, Cost, Chaos	    Global Accelerator + Route53 ARC, Aurora Global, DynamoDB Global, SQS/SNS cross-region, Savings Plans 	                “I design 9’s availability, sub-$1M cost, and survive region failures”
                                                                                                    + Reserved Instances + Graviton, Chaos Engineering (Fault Injection Simulator), Well-Architected Framework reviews        



THE 15 GOLDEN SERVICE COMBINATIONS (Memorise these – they win every interview)

#,  Scenario,                       Winning Stack (2025),                                                                           Why it wins
--------------------------------------------------------------------------------------------------------------------------------------------------------------------
1,  Multi-account foundation,       Control Tower + Organizations + IAM Identity Center + Tag/SCP policies,                         Industry standard landing zone
2,  Zero-trust IaC,                 OIDC + GitHub Actions + GitHub Codespaces,                                                      No keys ever
3,  Networking,                     Transit Gateway + VPC Peering + PrivateLink + Route53 Resolver,                                 "Centralised, secure, cheap"
4,  Compute,                        EKS (IRSA) + ECS Fargate + Lambda + Graviton,                                                   Cost + performance king
5,  Database,                       Aurora PostgreSQL (multi-AZ) + DynamoDB + ElastiCache + RDS Proxy,                              99.99% + auto-scale
6,  Serverless,                     Lambda + EventBridge + Step Functions + SQS + DynamoDB,                                         True zero-ops
7,  Observability,                  CloudWatch + X-Ray + Prometheus/Grafana (AMP/APM) + Synthetics Canaries,                        Full tracing + alerting
8,  Security,                       GuardDuty + Security Hub + Macie + WAF + Shield Advanced + Detective,                           RBI/PCI/GDPR auto-pass
9,  Cost control,                   Cost Explorer + Budgets + Savings Plans + Compute Optimizer + Graviton,                         40-60% savings guaranteed
10, Disaster Recovery,              Route53 Health Checks + Global Accelerator + S3 Cross-Region Replication + Aurora Global,       "RPO < 1s, RTO < 15 min"
11, GitOps,                         ArgoCD or Flux + Crossplane + Helm,                                                             Kubernetes + AWS resources as YAML
12, Data Lake,                      S3 + Glue + Athena + Lake Formation + QuickSight,                                               Petabyte-scale analytics
13, Multi-tenant SaaS,              Cognito + AppSync + Tenant isolation (silo/pool),                                               Real B2B SaaS pattern
14, FinTech / Banking,              KMS multi-region + Macie + CloudTrail Org + Config Rules + EKS + PrivateLink everywhere,        RBI/PCI-DSS mandatory
15, Global apps,                    Global Accelerator + CloudFront + S3 Transfer Acceleration + Edge Lambda,                       <50ms latency worldwide


AWS A-to-Z BASICS CHEAT SHEET

Requirement / Use-case,                         Best AWS Service(s) in 2025,                                Why it wins + Cost hint,                            Interview one-liner
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
Static website (HTML/CSS/JS),                   S3 + CloudFront + Route53 + ACM,                            $0.50–$2/month,                                     “S3 static + CloudFront = global <50ms”
Dynamic website (React/Vue/Node/PHP),           S3 + CloudFront (for static) + API Gateway + Lambda,        "Serverless, pay-per-request",                      “Fully serverless front + back”
WordPress / traditional CMS,                    Lightsail or EC2 + RDS + EFS,                               Easy if you love traditional,                       “Lightsail = WordPress in 2 clicks”
High-traffic web app,                           ALB + ECS Fargate / EKS + ElastiCache + RDS/Aurora,         "Auto-scale, zero servers",                         “Containerised + cache = 10k RPS easy”
Serverless API (REST/GraphQL),                  API Gateway + Lambda or AppSync (GraphQL),                  Pay per million calls,                              “API Gateway + Lambda = no EC2 ever”
"Real-time features (chat, notifications)",     AppSync + Cognito + DynamoDB Streams,                       Real-time subscriptions,                            “AppSync = real-time without WebSocket code”
File storage / user uploads,                    S3 + CloudFront,                                            Infinite + cheap,                                   “S3 is the only unlimited storage”
Large files / video streaming,                  S3 + CloudFront + MediaConvert/MediaLive,                   CDN + transcoding,                                  “CloudFront = Netflix-grade delivery”
"Database – relational, OLTP",                  Aurora PostgreSQL/MySQL (Serverless v2),                    Auto-scale to zero,                                 “Aurora Serverless = pay only when used”
"Database – NoSQL, high write",                 DynamoDB,                                                   "Millions RPS, single-digit ms",                    “DynamoDB = infinite scale without sharding”
Cache (Redis/Memcached),                        ElastiCache (Redis) or DynamoDB Accelerator (DAX),          Sub-ms latency,                                     “DAX = DynamoDB at RAM”
Search,                                         OpenSearch Service,                                         Full-text + analytics,                              “OpenSearch = Elasticsearch managed”
Queue / background jobs,                        SQS + Lambda or SNS,                                        "Decoupled, reliable",                              “SQS = never lose a job”
Email / SMS,                                    SES + SNS,                                                  ₹7 per 100k emails,                                 “SES = cheapest email in the world”
Authentication,                                 Cognito User Pools + Hosted UI,                             OAuth2/OIDC built-in,                               “Cognito = login without writing auth code”
Internal tools / admin panels,                  Amplify Studio + Cognito + AppSync,                         No backend code,                                    “Amplify Studio = CRUD app in 10 min”
VPN / on-prem connect,                          Site-to-Site VPN or AWS Client VPN,                         Cheap vs Direct Connect,                            “VPN = secure tunnel in 5 min”
Private connectivity between VPCs,              Transit Gateway,                                            "Hub-and-spoke, cheap",                             “TGW = internet for VPCs”
Expose private APIs securely,                   PrivateLink + NLB,                                          No public internet,                                 “PrivateLink = AWS marketplace for APIs”
Monitoring & logs,                              CloudWatch + X-Ray + Synthetics Canaries,                   Full tracing,                                       “X-Ray = debug serverless in seconds”
Cost control,                                   Cost Explorer + Budgets + Savings Plans,                    60%+ savings,                                       “Savings Plans = Netflix billing trick”
Backup / DR,                                    AWS Backup + S3 Cross-Region Replication,                   Automated,                                          “AWS Backup = one-click for everything”
Machine Learning (basic),                       SageMaker Built-in Algorithms or Bedrock,                   No GPU management,                                  “Bedrock = ChatGPT in your VPC”


GOLDEN RULES EVERY PRINCIPAL ARCHITECT FOLLOWS

- Never use EC2 unless forced → Fargate/Lambda first
- Never store secrets in code → Secrets Manager / Parameter Store
- Never use access keys → IAM Roles + OIDC everywhere
- Never make S3 buckets public → Block Public Access + CloudFront OAC
- Never run without remote state + locking
- Never deploy without terraform plan review in PR
- Never pay full price → Savings Plans + Graviton = 60% cheaper