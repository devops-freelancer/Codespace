terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.39.1"
    }
  }
}
provider "aws" {
  region = var.region 
}

provider "aws" {
  alias = "cross-account"
  region = var.region 
}

