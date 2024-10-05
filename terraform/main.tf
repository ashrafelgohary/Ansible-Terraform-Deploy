# Configure the AWS provider
provider "aws" {
  region = "us-east-1"
}

# # Generate SSH Key Pair
# resource "tls_private_key" "ssh_key" {
#   algorithm = "RSA"
#   rsa_bits  = 4096
# }

# resource "aws_key_pair" "deployer_key" {
#   key_name   = "deployer-key"
#   public_key = tls_private_key.ssh_key.public_key_openssh
# }

# Security group to allow SSH and HTTP
resource "aws_security_group" "allow_ssh_http" {
  name        = "allow_ssh_http"

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description      = "Allow HTTPS traffic"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch EC2 instances
resource "aws_instance" "web" {
  count         = 2
  ami           = "ami-0fff1b9a61dec8a5f"  # Amazon Linux 2 AMI
  instance_type = "t2.micro"

  #key_name               = aws_key_pair.deployer_key.key_name
  key_name      = "ashrafelgoharykey"
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]

  tags = {
    Name = "WebServer-${count.index + 1}"
  }
}

# # Output the public IPs
# output "instance_ips" {
#   value = aws_instance.web[*].public_ip
# }

# # Output the private key to SSH into instances
# output "private_key" {
#   value     = tls_private_key.ssh_key.private_key_pem
#   sensitive = true
# }
