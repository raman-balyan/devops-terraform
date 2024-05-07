variable "environment" {
  description = "The deployment environment (e.g., dev, staging, prod)"
  type        = string
  default     = "dev" 
}

variable "tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {
    Project = "My Terraform Project"
    Owner   = "Raman"
  }
}

variable "aws_region" {
  description = "AWS region to use"
  type        = string
  default     = "us-west-1"
}

variable "aws_access_key" {
  description = "AWS Access Key ID for the target AWS account"
  type        = string
}

variable "aws_secret_key" {
  description = "AWS Secret Key for the target AWS account"
  type        = string
}

variable "aws_session_token" {
  description = "AWS Session Token for the target AWS account. Required only if authenticating using temporary credentials"
  type        = string
  default     = ""
}

variable "vpc_cidr" {
  description = "The IPv4 CIDR block to use for the VPC"
  type        = string
  default     = "192.170.0.0/20"
}

variable "availability_zone" {
  description = "The Availability Zone where the subnets will be created"
  type        = string
}
