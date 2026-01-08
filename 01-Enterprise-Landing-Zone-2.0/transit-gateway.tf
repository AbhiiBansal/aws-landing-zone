# Phase 3: The Enterprise Highway (Transit Gateway)
# This acts as the central router connecting all future VPCs (Dev, Prod, Shared)

module "transit_gateway" {
  source  = "terraform-aws-modules/transit-gateway/aws"
  version = "2.10.0"

  name        = "enterprise-tgw"
  description = "The central hub for all VPC traffic"

  # The "ID Card" of the router (Standard Private ASN)
  amazon_side_asn = 64512

  # Enable Auto-Accept to make our lives easier in this project
  # (In a strict bank, this might be false, but for us, true is fine)
  enable_auto_accept_shared_attachments = true

  # Enable Multi-Account Sharing (Crucial for Phase 4)
  enable_ram_resource_share = true
  ram_resource_share_name   = "enterprise-tgw-share"

  # Attach the Shared Services VPC (Phase 2) to this Highway immediately
  vpc_attachments = {
    shared_services = {
      vpc_id       = module.vpc.vpc_id
      subnet_ids   = module.vpc.private_subnets # We connect the Private Subnets to the Highway
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