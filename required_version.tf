terraform {
  #required_version = "<= 1.3.0" #Forcing which version of Terraform needs to be used
  required_providers {
    aws = {
      version = "<= 5.0.0" #Forcing which version of plugin needs to be used.
      source  = "hashicorp/aws"
    }
  }
  backend "s3" {
    bucket         = "devopsb28terraformstate"
    key            = "devopsb28fun.tfstate"
    dynamodb_table = "terraform-state-lock-dynamo"
    encrypt        = true
    region         = "us-east-1"
  }
}
