variable "aws_region" {
  description = "The AWS Region to deploy into"
  type        = string
  default     = "ap-south-1"
}

variable "hub_account_id" {
  description = "AWS Account ID for Shared Services (Hub)"
  type        = string
}

variable "dev_account_id" {
  description = "AWS Account ID for Development (Spoke 1)"
  type        = string
}

variable "prod_account_id" {
  description = "AWS Account ID for Production (Spoke 2)"
  type        = string
}