AWS SOLUTION ARCHITECT CHEAT SHEET – 3 OPTIONS FRAMEWORK
(Your lifetime weapon – 2025 India market – 50–120 LPA roles)


Golden Rules (always ask these 5 questions first – never propose without them)

1) Business goal? (growth, cost save, compliance, speed to market)
2) Expected traffic/data volume? (10 users or 10 million?)
3) Compliance needs? (RBI, PCI, GDPR, ISO, HIPAA)
4) Budget & timeline?
5) Team skill level? (serverless newbies or Kubernetes experts?)


3 OPTIONS FRAMEWORK (always present like this)

| Scenario / Requirement          | Option 1 – GOOD (MVP / Fast & Cheap) | Option 2 – BETTER (Balanced)      | Option 3 – BEST (Enterprise / Bank-Grade)          | Key Trade-offs (Cost          | Time                | Risk                    | Scalability)    | Recommended When
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
| Web App Hosting                 | S3 + CloudFront + Route53            | Amplify (full-stack)              | ALB + ECS Fargate / EKS + Auto Scaling             | Cost: free                    | Time: Fast          | Risk: Low               | Scale: High     | Startup MVP      
| Authentication                  | Cognito User Pools (Hosted UI)       | Cognito + Custom Lambda triggers  | Cognito + External OIDC (Okta/Azure AD)            | Cost: Free → $                | Time: 1 day → 1 week| Risk: Low → Medium      | Scale: High     | Compliance heavy
| API Backend                     | API Gateway + Lambda                 | API Gateway + ECS Fargate         | API Gateway + EKS + PrivateLink                    | Cost: Pay-per-request → $200+ | Time: Fast → Weeks  | Risk: Low → Low         | Scale: High     | High traffic 
| Database – OLTP                 | DynamoDB                             | Aurora Serverless v2              | Aurora Multi-AZ + Read Replicas                    | Cost: Pay-per-use → $300+     | Time: Fast → Medium | Risk: Low → Very Low    | Scale: High     | RBI/PCI 
| Database – OLAP / Analytics     | S3 + Athena                          | Redshift Serverless               | Redshift RA3 + Spectrum                            | Cost: $ → $500+               | Time: Fast → Medium | Risk: Low               | Scale: High     | Big data 
| File Storage                    | S3 Standard                          | S3 Intelligent-Tiering            | S3 + Glacier Deep Archive + Lifecycle              | Cost: Low → Lowest            | Time: Fast          | Risk: Retrieval delay   | Scale: Infinite | Long-term 
| Cache                           | DAX (for DynamoDB)                   | ElastiCache Redis                 | ElastiCache Redis Cluster                          | Cost: $ → $300+               | Time: Fast → Medium | Risk: Low               | Scale: High     | High performance 
| Queue / Decoupling              | SQS Standard                         | SQS FIFO                          | SNS + SQS Fanout                                   | Cost: Free → Low              | Time: Fast          | Risk: Low               | Scale: High     | Order matters 
| Search                          | OpenSearch Serverless                | OpenSearch Managed                | OpenSearch + UltraWarm                             | Cost: Pay-per-use → $500+     | Time: Fast → Medium | Risk: Low               | Scale: High     | Large logs 
| Compute                         | Lambda                               | ECS Fargate                       | EKS (Fargate or EC2)                               | Cost: Pay-per-use → $300+     | Time: Fast → Weeks  | Risk: Low → Medium      | Scale: High     | Kubernetes teams 
| Networking                      | Public VPC                           | VPC + PrivateLink                 | Transit Gateway + PrivateLink + Direct Connect     | Cost: Low → $1000+            | Time: Fast → Weeks  | Risk: Medium → Low      | Scale: High     | Banking 
| Observability                   | CloudWatch basic                     | CloudWatch + X-Ray                | CloudWatch + Grafana + Prometheus (AMP)            | Cost: Low → $500+             | Time: Fast → Medium | Risk: Low               | Scale: High     | Critical apps 
| Security                        | Security Hub + GuardDuty             | + Macie + WAF                     | + Shield Advanced + Detective + Private CA         | Cost: Low → $2000+            | Time: Fast → Medium | Risk: Medium → Very Low | Scale: High     | RBI/PCI 
| Cost Optimization               | Free tier + Budget alerts            | Savings Plans + Cost Explorer     | Compute Optimizer + Graviton + Reserved Instances  | Cost: 0 → 60% savings         | Time: Fast → Medium | Risk: Low               | Scale: High     | All projects 
| Disaster Recovery               | Pilot Light (S3 replication)         | Warm Standby (multi-AZ)           | Multi-Region Active-Active                         | Cost: Low → High              | Time: Fast → Months | Risk: Medium → Very Low | Scale: High     | Banking 
| Compliance Logging              | CloudTrail + S3                      | CloudTrail Org + GuardDuty        | CloudTrail Org + Security Hub + Detective          | Cost: Low → Medium            | Time: Fast          | Risk: Low               | Scale: High     | RBI/PCI 


Extra Decision Columns (use these to pick fast)

Compliance Required?    Traffic Volume  Budget Tight?   Team Skill              Recommended Option
----------------------------------------------------------------------------------------------------
No,                         Low,            Yes,        Serverless new,         GOOD
RBI/PCI,                    High,           Medium,     Mixed,                  BETTER,
RBI/PCI + Global,           Very High,      No limit,   Kubernetes experts,     BEST


Your interview script (say this every time)

- “First, I ask the 5 golden questions to understand business goals.
- Then I propose 3 options: Good (fast & cheap), Better (balanced), Best (enterprise).
- I always explain trade-offs in cost, time, risk, and scalability.
- I recommend based on their answers – never one-size-fits-all.”
