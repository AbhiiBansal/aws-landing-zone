# -----------------------------------------------------------------------
# PHASE 6: NETWORK ROUTING (GPS)
# -----------------------------------------------------------------------
# This guides traffic from the VPC subnets into the Transit Gateway.
# We route the entire "10.0.0.0/8" Supernet to the TGW.

# 1. SHARED SERVICES (HUB) -> TGW
resource "aws_route" "hub_to_tgw" {
  # Loop through all Private Route Tables in the Hub
  count                  = length(module.vpc.private_route_table_ids)
  route_table_id         = module.vpc.private_route_table_ids[count.index]
  
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = module.transit_gateway.ec2_transit_gateway_id
}

# 2. DEV ACCOUNT -> TGW
resource "aws_route" "dev_to_tgw" {
  provider = aws.dev
  
  count                  = length(module.dev_vpc.private_route_table_ids)
  route_table_id         = module.dev_vpc.private_route_table_ids[count.index]
  
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = module.transit_gateway.ec2_transit_gateway_id
}

# 3. PROD ACCOUNT -> TGW
resource "aws_route" "prod_to_tgw" {
  provider = aws.prod
  
  count                  = length(module.prod_vpc.private_route_table_ids)
  route_table_id         = module.prod_vpc.private_route_table_ids[count.index]
  
  destination_cidr_block = "10.0.0.0/8"
  transit_gateway_id     = module.transit_gateway.ec2_transit_gateway_id
}