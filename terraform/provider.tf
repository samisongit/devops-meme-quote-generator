# terraform/provider.tf
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # Use a recent major version
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region # Use a variable for the region
}