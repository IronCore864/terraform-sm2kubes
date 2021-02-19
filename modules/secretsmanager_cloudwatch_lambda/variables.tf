variable "lambda_s3_bucket" {
  type = string
}

variable "lambda_s3_key" {
  type = string
}

variable "eks_region" {
  description = "The region where the eks cluster is running so that lambda can sync secrets from Secrets Manager to that cluster."
  type        = string
}
