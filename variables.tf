variable "aws_region" {
  description = "AWS region to deploy into"
  type        = string
  default     = "us-east-1"
}

variable "aws_account_id" {
  description = "AWS Account ID where resources will be created"
  type        = string
}

variable "app_name" {
  description = "The name of the application, used for ECR, App Runner, IAM roles, etc."
  type        = string
  default     = "my-app"   # optional default; can be overridden in terraform.tfvars
}
