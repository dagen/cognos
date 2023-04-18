# SETTINGS.tf

# Terraform Settings are created in the 'terraform{}' block.
# Here, we are staging that we require the AWS provider by hashicorp
# and that it must use version 4.0 or greater of the provider

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Additional configuration specific to our provider is managed in this
# 'provider{}' block.  Here, we are simply adding an input argument
# specifying our preferred region (found in environment.auto.tfvars)

provider "aws" {
  region  = var.region  
}