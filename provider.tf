provider "aws" {
  region = local.region
  default_tags {
    tags = local.default_provider_tags
  }
}

terraform {
  required_providers {
    aws = {
      version = "~> 5.32.1"
    }
  }
  required_version = ">= 0.14"
}



