# -----------------------------------------------------------------------
# PHASE 7: SMOKE TEST INFRASTRUCTURE
# -----------------------------------------------------------------------
# This deploys temporary test servers to verify connectivity.

# 1. GET THE LATEST AMAZON LINUX AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# 2. IAM ROLE FOR SSM (SESSION MANAGER)
# This allows us to log in via the Console (No SSH keys needed)
resource "aws_iam_role" "ssm_role" {
  name = "systems-manager-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action = "sts:AssumeRole"
      Effect = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ssm-instance-profile"
  role = aws_iam_role.ssm_role.name
}

# 3. SECURITY GROUP (ALLOW PING)
resource "aws_security_group" "allow_ping" {
  name        = "allow-internal-ping"
  description = "Allow ping from internal network"
  vpc_id      = module.vpc.vpc_id # Created in Hub VPC

  ingress {
    description = "Allow Ping from 10.0.0.0/8"
    from_port   = -1
    to_port     = -1
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

# 4. SERVER A: SHARED SERVICES (THE SOURCE)
resource "aws_instance" "hub_tester" {
  ami                  = data.aws_ami.amazon_linux.id
  instance_type        = "t3.micro"
  subnet_id            = module.vpc.private_subnets[0]
  iam_instance_profile = aws_iam_instance_profile.ssm_profile.name
  vpc_security_group_ids = [aws_security_group.allow_ping.id]

  tags = { Name = "hub-test-server" }
}

# 5. SERVER B: DEV ACCOUNT (THE DESTINATION)
resource "aws_instance" "dev_tester" {
  provider = aws.dev # Launch in Dev Account

  ami                  = data.aws_ami.amazon_linux.id
  instance_type        = "t3.micro"
  subnet_id            = module.dev_vpc.private_subnets[0]
  
  # Note: In a real org, we would create a separate role in Dev. 
  # For this simple test, we skip the role in Dev (we only need to ping IT, not log into it).
  # We just need a security group in Dev to allow the ping.
}

# 6. SECURITY GROUP FOR DEV (Allow Ping)
resource "aws_security_group" "dev_allow_ping" {
  provider    = aws.dev
  name        = "dev-allow-ping"
  description = "Allow ping from Hub"
  vpc_id      = module.dev_vpc.vpc_id

  ingress {
    description = "Allow Ping from 10.0.0.0/8"
    from_port   = -1
    to_port     = -1
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

# Attach the SG to the Dev Instance
resource "aws_network_interface_sg_attachment" "sg_attachment" {
  provider             = aws.dev
  security_group_id    = aws_security_group.dev_allow_ping.id
  network_interface_id = aws_instance.dev_tester.primary_network_interface_id
}