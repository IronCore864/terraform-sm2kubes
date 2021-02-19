module "secretsmanager_cloudwatch_lambda" {
  source = "./modules/secretsmanager_cloudwatch_lambda"

  lambda_s3_bucket = var.lambda_s3_bucket
  lambda_s3_key    = var.lambda_s3_key
  eks_region       = var.eks_region
}
