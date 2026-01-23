# -----------------------------------------------------------------------
# ROUTING TABLES (GPS)
# -----------------------------------------------------------------------
# We update the PUBLIC route tables because in Zero-Cost mode, 
# that is where our active workloads live.

# 1. HUB ROUTES
# Traffic to Dev (10.1.0.0/16) -> Goes to Dev Peering
resource "aws_route" "hub_to_dev" {
  count                     = length(module.vpc.public_route_table_ids)
  route_table_id            = module.vpc.public_route_table_ids[count.index]
  destination_cidr_block    = "10.1.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_dev.id
}

# Traffic to Prod (10.2.0.0/16) -> Goes to Prod Peering
resource "aws_route" "hub_to_prod" {
  count                     = length(module.vpc.public_route_table_ids)
  route_table_id            = module.vpc.public_route_table_ids[count.index]
  destination_cidr_block    = "10.2.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_prod.id
}

# 2. DEV ROUTES
# Traffic to Hub (10.0.0.0/16) -> Goes to Hub Peering
resource "aws_route" "dev_to_hub" {
  provider                  = aws.dev
  count                     = length(module.dev_vpc.public_route_table_ids)
  route_table_id            = module.dev_vpc.public_route_table_ids[count.index]
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_dev.id
}

# 3. PROD ROUTES
# Traffic to Hub (10.0.0.0/16) -> Goes to Hub Peering
resource "aws_route" "prod_to_hub" {
  provider                  = aws.prod
  count                     = length(module.prod_vpc.public_route_table_ids)
  route_table_id            = module.prod_vpc.public_route_table_ids[count.index]
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_prod.id
}
# --- STAGING ROUTES ---

# 1. Hub -> Staging
resource "aws_route" "hub_to_staging" {
  count                     = length(module.vpc.public_route_table_ids)
  route_table_id            = module.vpc.public_route_table_ids[count.index]
  destination_cidr_block    = "10.3.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_staging.id
}

# 2. Staging -> Hub
resource "aws_route" "staging_to_hub" {
  provider                  = aws.staging
  count                     = length(module.staging_vpc.public_route_table_ids)
  route_table_id            = module.staging_vpc.public_route_table_ids[count.index]
  destination_cidr_block    = "10.0.0.0/16"
  vpc_peering_connection_id = aws_vpc_peering_connection.hub_to_staging.id
}