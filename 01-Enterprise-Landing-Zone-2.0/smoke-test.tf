# -----------------------------------------------------------------------------
# SMOKE TEST: Verification Instances (FIXED VERSION)
# -----------------------------------------------------------------------------

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"]
  }
}

# -----------------------------------------------------------------------------
# DEV ACCOUNT RESOURCES (Spoke 1)
# -----------------------------------------------------------------------------

resource "aws_iam_role" "dev_ssm_role" {
  provider = aws.dev
  name     = "DevSSMRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" } }]
  })
}

resource "aws_iam_role_policy_attachment" "dev_ssm_attach" {
  provider   = aws.dev
  role       = aws_iam_role.dev_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "dev_profile" {
  provider = aws.dev
  name     = "DevSSMProfile"
  role     = aws_iam_role.dev_ssm_role.name
}

# --- THE FIX: NEW SECURITY GROUP FOR DEV ---
resource "aws_security_group" "dev_tester_sg" {
  provider    = aws.dev
  name        = "dev-tester-sg"
  description = "Allow Outbound Traffic for SSM"
  vpc_id      = module.dev_vpc.vpc_id

  # Allow Server to reach AWS SSM (Internet)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Allow Ping (ICMP) from internal network
  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8"]
  }
}

resource "aws_instance" "dev_tester" {
  provider               = aws.dev
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = module.dev_vpc.private_subnets[0]
  iam_instance_profile   = aws_iam_instance_profile.dev_profile.name
  
  # UPDATED TO USE NEW SECURITY GROUP
  vpc_security_group_ids = [aws_security_group.dev_tester_sg.id]

  tags = {
    Name = "dev-connectivity-tester"
  }
}

# -----------------------------------------------------------------------------
# PROD ACCOUNT RESOURCES (Spoke 2)
# -----------------------------------------------------------------------------

resource "aws_iam_role" "prod_ssm_role" {
  provider = aws.prod
  name     = "ProdSSMRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{ Action = "sts:AssumeRole", Effect = "Allow", Principal = { Service = "ec2.amazonaws.com" } }]
  })
}

resource "aws_iam_role_policy_attachment" "prod_ssm_attach" {
  provider   = aws.prod
  role       = aws_iam_role.prod_ssm_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "prod_profile" {
  provider = aws.prod
  name     = "ProdSSMProfile"
  role     = aws_iam_role.prod_ssm_role.name
}

# --- THE FIX: NEW SECURITY GROUP FOR PROD ---
resource "aws_security_group" "prod_tester_sg" {
  provider    = aws.prod
  name        = "prod-tester-sg"
  description = "Allow Outbound Traffic for SSM"
  vpc_id      = module.prod_vpc.vpc_id

  # Allow Server to reach AWS SSM (Internet)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["10.0.0.0/8"]
  }
}

resource "aws_instance" "prod_tester" {
  provider               = aws.prod
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t3.micro"
  subnet_id              = module.prod_vpc.private_subnets[0]
  iam_instance_profile   = aws_iam_instance_profile.prod_profile.name

  # UPDATED TO USE NEW SECURITY GROUP
  vpc_security_group_ids = [aws_security_group.prod_tester_sg.id]

  tags = {
    Name = "prod-connectivity-tester"
  }
}