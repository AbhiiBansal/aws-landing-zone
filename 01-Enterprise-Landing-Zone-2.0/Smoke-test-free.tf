# -----------------------------------------------------------------------------
# FREE TIER SMOKE TEST (Public Subnets)
# -----------------------------------------------------------------------------
# Uses EC2 instances in Public Subnets to verify connectivity.

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# 1. DEV TESTER
resource "aws_security_group" "dev_sg" {
  provider = aws.dev
  name     = "dev-ping-sg"
  vpc_id   = module.dev_vpc.vpc_id

  # Allow Ping from internal network (10.0.0.0/8)
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8"]
  }
  
  # Allow Internet Access (for updates/SSM)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "dev_tester" {
  provider                    = aws.dev
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  # PLACEMENT: Public Subnet so we don't need NAT
  subnet_id                   = module.dev_vpc.public_subnets[0] 
  vpc_security_group_ids      = [aws_security_group.dev_sg.id]
  associate_public_ip_address = true
  
  tags = { Name = "dev-connectivity-tester" }
}

# 2. PROD TESTER
resource "aws_security_group" "prod_sg" {
  provider = aws.prod
  name     = "prod-ping-sg"
  vpc_id   = module.prod_vpc.vpc_id

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "prod_tester" {
  provider                    = aws.prod
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = module.prod_vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.prod_sg.id]
  associate_public_ip_address = true
  
  tags = { Name = "prod-connectivity-tester" }
}
# 3. STAGING TESTER
resource "aws_security_group" "staging_sg" {
  provider = aws.staging
  name     = "staging-ping-sg"
  vpc_id   = module.staging_vpc.vpc_id

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "staging_tester" {
  provider                    = aws.staging
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = "t3.micro"
  subnet_id                   = module.staging_vpc.public_subnets[0]
  vpc_security_group_ids      = [aws_security_group.staging_sg.id]
  associate_public_ip_address = true
  
  tags = { Name = "staging-connectivity-tester" }
}