# terraform/main.tf

# --- Data Sources ---
# Find the latest Amazon Linux 2 AMI
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-x86_64"] # Amazon Linux 2023
  }
}

# --- Resources ---

# VPC
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr_block # Use variable

  tags = {
    Name = "${var.environment}-VPC" # Use environment variable for tagging
  }
}

# Internet Gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "DevOps-Project-IGW"
  }
}

# Public Subnet
resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr_block # Use variable
  availability_zone       = "${var.aws_region}a"
  map_public_ip_on_launch = true

  tags = {
    Name = "${var.environment}-Public-Subnet" # Use environment variable for tagging
  }
}

# Route Table for Public Subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }

  tags = {
    Name = "DevOps-Project-Public-RT"
  }
}

# Associate Route Table with Public Subnet
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Security Group for EC2 Instance
resource "aws_security_group" "web" {
  name        = "allow_web_traffic"
  description = "Allow inbound web traffic"
  vpc_id      = aws_vpc.main.id

  # Inbound Rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: For production, restrict this to YOUR IP!
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000 # Flask default port
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # WARNING: For production, restrict this!
  }

  # Outbound Rules (allow all outbound traffic)
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All protocols
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "DevOps-Project-SG"
  }
}

# EC2 Instance
resource "aws_instance" "web_app" {
  # Use AMI ID from variable if provided, otherwise use data source
  ami           = var.ami_id != "" ? var.ami_id : data.aws_ami.amazon_linux.id
  instance_type = var.instance_type

  # Place instance in the public subnet
  subnet_id = aws_subnet.public.id

  # Associate the security group
  vpc_security_group_ids = [aws_security_group.web.id]

  # Use the SSH key pair (you need to create this - see next steps/comments)
  key_name = var.ssh_key_name # Uncomment and set variable when you have an SSH key

  # Basic user data script to install Docker (Ansible will configure the app)
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y docker
              usermod -a -G docker ec2-user # Add ec2-user to docker group
              systemctl enable docker
              systemctl start docker
              EOF

  tags = {
    Name = "DevOps-Project-Web-App"
  }
}
