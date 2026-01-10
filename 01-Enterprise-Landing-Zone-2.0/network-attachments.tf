# -----------------------------------------------------------------------
# PHASE 5: TRANSIT GATEWAY ATTACHMENTS
# -----------------------------------------------------------------------
# This plugs the Spoke VPCs into the Central Router.

# 1. ATTACH DEV VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "dev" {
  provider = aws.dev # This creates the resource inside the DEV account

  subnet_ids         = module.dev_vpc.private_subnets
  transit_gateway_id = module.transit_gateway.ec2_transit_gateway_id
  vpc_id             = module.dev_vpc.vpc_id

  tags = {
    Name = "dev-vpc-attachment"
  }
}

# 2. ATTACH PROD VPC
resource "aws_ec2_transit_gateway_vpc_attachment" "prod" {
  provider = aws.prod # This creates the resource inside the PROD account

  subnet_ids         = module.prod_vpc.private_subnets
  transit_gateway_id = module.transit_gateway.ec2_transit_gateway_id
  vpc_id             = module.prod_vpc.vpc_id

  tags = {
    Name = "prod-vpc-attachment"
  }
}