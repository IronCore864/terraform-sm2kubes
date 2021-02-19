output "lambda_role_arn" {
  value = aws_iam_role.secretsmanager_eks_sync.arn
}
