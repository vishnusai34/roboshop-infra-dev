terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.98.0"
    }
  }

  backend "s3" {
    bucket         = "vaws-remote-state"
	  key          = "roboshop-dev-backend-catalogue_service"
	  region         = "us-east-1"
	  encrypt        = true
	  use_lockfile   = true
  }
}

provider "aws" {
  # Configuration options
  region = "us-east-1"
}