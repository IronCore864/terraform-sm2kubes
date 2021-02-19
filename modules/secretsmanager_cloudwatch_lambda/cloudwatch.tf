resource "aws_cloudwatch_event_rule" "secretsmanager" {
  name        = "secrets-manager-api"
  description = "Capture Secrets Manager create, update, delete API calls"

  event_pattern = <<EOF
{
  "source": [
    "aws.secretsmanager"
  ],
  "detail": {
    "eventSource": [
      "secretsmanager.amazonaws.com"
    ],
    "eventName": [
      "CreateSecret",
      "PutSecretValue",
      "DeleteSecret"
    ]
  }
}
EOF
}

resource "aws_cloudwatch_event_target" "secretsmanager_eks_sync" {
  arn  = aws_lambda_function.secretsmanager_eks_sync.arn
  rule = aws_cloudwatch_event_rule.secretsmanager.id
}
