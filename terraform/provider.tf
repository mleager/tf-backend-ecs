terraform {
  backend "s3" {
    bucket       = "tf-state-8864"
    key          = "tf-backend-ecs/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.99.1"
    }
  }
  required_version = "~> 1.12.1"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Project     = var.project
      Environment = var.env
    }
  }
}

