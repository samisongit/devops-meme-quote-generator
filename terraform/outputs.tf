# terraform/outputs.tf

output "ec2_instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.web_app.public_ip
}

output "ec2_instance_private_ip" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.web_app.private_ip
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.web_app.id
}


# Optional: Output the Security Group ID if needed elsewhere
# output "web_security_group_id" {
#   description = "The ID of the web security group"
#   value       = aws_security_group.web.id
# }

# Optional: Output the VPC ID
# output "vpc_id" {
#   description = "The ID of the created VPC"
#   value       = aws_vpc.main.id
# }

# terraform/outputs.tf (optional additions)

# output "ssh_key_name_used" {
#   description = "The name of the SSH key pair assigned to the EC2 instance"
#   value       = var.ssh_key_name
# }

# output "web_security_group_id" {
#   description = "The ID of the web security group"
#   value       = aws_security_group.web.id
# }