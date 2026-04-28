# Variables are like function parameters — they make your code reusable
# Instead of hardcoding values, you define them here and pass values via terraform.tfvars

variable "aws_region" {
  description = "Primary AWS region"   # Documents what this variable is for
  type        = string                  # Must be a string value
  default     = "ap-southeast-1"       # Used if no value is provided in tfvars
}

variable "domain_name" {
  description = "Your domain name e.g. yourdomain.com"
  type        = string
  # No default — this is REQUIRED, Terraform will error if not provided
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "static-website"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "github_repo_owner" {
  description = "Your GitHub username"
  type        = string
}

variable "github_repo_name" {
  description = "Your GitHub repository name"
  type        = string
}

variable "branch_name" {
  description = "Branch to deploy from"
  type        = string
  default     = "main"
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true  # Marks this as secret — Terraform won't print it in logs
}