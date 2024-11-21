terraform {
  #   required_version = "<= 1.3.0" #Forcing which version of terraform to use
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" #Forcing which version of plugin to use
    }
  }
  backend "s3" {
    bucket         = "devopsb28terraformstate"
    key            = "functions1.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt        = true
    region         = "us-east-1"
  }
}
