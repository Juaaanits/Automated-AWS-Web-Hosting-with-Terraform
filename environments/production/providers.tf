# This is for letting the Terraform talk directly to AWS

terraform {
    required_providers {
        aws = {
            source = "hashicorp/aws" 
            version = "~> 6.0"
        }
    }
    required_version = ">= 1.0"
}

# Main Provider 
provider "aws" {
    region = var.aws_region
}

provider "aws" {
    alias = "us_east_1"
    region = "us-east-1"
}

