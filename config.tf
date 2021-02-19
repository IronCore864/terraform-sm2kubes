terraform {
  # Tested with 0.14.2 and 0.14.7; lower version could work too but not tested.
  required_version = ">= 0.14.2"
  required_providers {
    aws = {
      # Tested with 3.28; lower version could work too but not tested.
      version = ">= 3.28"
      source  = "hashicorp/aws"
    }
  }

  # Here I'm using S3 as the Terraform backend with DynamoDB table as Terraform stack lock.
  # If you don't want to use the state lock or S3 backend, adjust this block accordingly.
  backend "s3" {
    bucket         = "tf-state-391996659322"
    key            = "secrets-manager-lambda.tfstate"
    region         = "eu-central-1"
    encrypt        = true
    dynamodb_table = "tf_state_lock_391996659322"
  }
}

provider "aws" {
  # My default region. Change accordingly to suit your situation.
  region = "eu-central-1"
}
