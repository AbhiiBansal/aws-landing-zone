# Phase 3: The Enterprise Highway (Transit Gateway)
# This acts as the central router connecting all future VPCs (Dev, Prod, Shared)

module "transit_gateway" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "2.10.0"

  name        = "enterprise-tgw"
  description = "The central hub for all VPC traffic"

  # The "ID Card" of the router (Standard Private ASN)
  amazon_side_asn = 64512

  # Enable Auto-Accept so we don't have to manually click "Yes"
  enable_auto_accept_shared_attachments = true

  # --- FIX START ---
  # These arguments were renamed/moved in newer module versions.
  # We use 'share_tgw' to enable RAM sharing now.
  share_tgw                 = true
  ram_name                  = "enterprise-tgw-share"
  # --- FIX END ---

  # Connect the Shared Services VPC to this Highway
  vpc_attachments = {
    shared_services = {
      vpc_id       = module.vpc.vpc_id
      subnet_ids   = module.vpc.private_subnets
      dns_support  = true
      ipv6_support = false
    }
  }

  tags = {
    Project     = "Enterprise-Landing-Zone"
    Environment = "Shared-Services"
    Role        = "Network-Hub"
  }
}