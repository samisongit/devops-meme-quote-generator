# terraform/variables.tf
variable "aws_region" {
  description = "The AWS region to deploy resources into"
  type        = string
  default     = "us-east-1" # Default region, change if needed
}

variable "instance_type" {
  description = "The EC2 instance type"
  type        = string
  default     = "t3.micro" # As per warning in the plan
}

# AMI ID can vary by region. We'll use a data source to find a suitable one.
# However, defining it as a variable allows overriding if needed.
variable "ami_id" {
  description = "The AMI ID for the EC2 instance. If empty, a data source will find one."
  type        = string
  default     = "" # Empty default means data source will be used
}

variable "ssh_key_name" {
  description = "cloud-engineer-key"
  type        = string
  # No default is set, so it must be provided. You can set one if you want.
  default     = "cloud-engineer-key"
}

# terraform/variables.tf (add these blocks)

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

# Optional: Environment tag
variable "environment" {
  description = "The environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}