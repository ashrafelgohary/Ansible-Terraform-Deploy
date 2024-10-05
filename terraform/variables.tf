variable "instance_type" {
  description = "The EC2 instance type"
  default     = "t2.micro"
}

variable "region" {
  description = "The AWS region to deploy in"
  default     = "us-east-1"
}
