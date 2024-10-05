output "instance_ips" {
  description = "The public IPs of the EC2 instances"
  value       = aws_instance.web[*].public_ip
}

# output "private_key" {
#   description = "Private SSH key to access the EC2 instances"
#   value       = tls_private_key.ssh_key.private_key_pem
#   sensitive   = true
# }

