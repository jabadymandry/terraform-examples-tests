terraform {
  cloud {
    organization = "emb"
    workspaces {
      name = "examples-tests-workspace"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>4.51.0"
    }
  }
  required_version = "~> 1.3.7"
}

provider "aws" {
  #profile = "default"
  region = "us-east-1"
}