# -----------------------------------------------------------------------
# COST-EFFICIENT ROUTING: VPC PEERING
# -----------------------------------------------------------------------

# 1. PEERING: HUB <--> DEV
# The Hub requests the connection
resource "aws_vpc_peering_connection" "hub_to_dev" {
  provider      = aws # Uses Hub Provider
  vpc_id        = module.vpc.vpc_id
  peer_vpc_id   = module.dev_vpc.vpc_id
  peer_owner_id = var.dev_account_id
  auto_accept   = false 

  tags = { Name = "Hub-to-Dev-Peering" }
}

# The Dev Account accepts the connection
resource "aws_vpc_peering_connection_accepter" "dev_accepter" {
  provider                  = aws.dev
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_dev.id
  auto_accept               = true
  tags = { Name = "Hub-to-Dev-Accepter" }
}

# 2. PEERING: HUB <--> PROD
# The Hub requests the connection
resource "aws_vpc_peering_connection" "hub_to_prod" {
  provider      = aws # Uses Hub Provider
  vpc_id        = module.vpc.vpc_id
  peer_vpc_id   = module.prod_vpc.vpc_id
  peer_owner_id = var.prod_account_id
  auto_accept   = false

  tags = { Name = "Hub-to-Prod-Peering" }
}

# The Prod Account accepts the connection
resource "aws_vpc_peering_connection_accepter" "prod_accepter" {
  provider                  = aws.prod
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_prod.id
  auto_accept               = true
  tags = { Name = "Hub-to-Prod-Accepter" }
}
# 3. PEERING: HUB <--> STAGING
resource "aws_vpc_peering_connection" "hub_to_staging" {
  provider      = aws # Hub Provider
  vpc_id        = module.vpc.vpc_id
  peer_vpc_id   = module.staging_vpc.vpc_id
  peer_owner_id = var.staging_account_id
  auto_accept   = false

  tags = { Name = "Hub-to-Staging-Peering" }
}

resource "aws_vpc_peering_connection_accepter" "staging_accepter" {
  provider                  = aws.staging
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_staging.id
  auto_accept               = true
  tags = { Name = "Hub-to-Staging-Accepter" }
}