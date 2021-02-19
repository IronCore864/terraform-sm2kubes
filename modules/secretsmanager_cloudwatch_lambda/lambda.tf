resource "aws_lambda_function" "secretsmanager_eks_sync" {
  function_name = "secretsmanager_eks_sync"
  role          = aws_iam_role.secretsmanager_eks_sync.arn
  s3_bucket     = var.lambda_s3_bucket
  s3_key        = var.lambda_s3_key
  handler       = "main"
  runtime       = "go1.x"

  environment {
    variables = {
      region = var.eks_region
    }
  }
}

# allowing the event rule to trigger this lambda
resource "aws_lambda_permission" "allow_events" {
  statement_id  = "AllowExecutionFromEvents"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.secretsmanager_eks_sync.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.secretsmanager.arn
}

resource "aws_lambda_function_event_invoke_config" "secretsmanager_eks_sync" {
  function_name          = aws_lambda_function.secretsmanager_eks_sync.function_name
  maximum_retry_attempts = 0
}
