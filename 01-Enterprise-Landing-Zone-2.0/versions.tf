terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }

  # This tells Terraform to store the state file in S3
  backend "s3" {
    bucket         = "awslz-terraform-state"
    key            = "landing-zone/terraform.tfstate"
    region         = "ap-south-1"
    encrypt        = true
    dynamodb_table = "awslz-terraform-locks"
  }
}