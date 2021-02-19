resource "aws_iam_role" "secretsmanager_eks_sync" {
  name = "LambdaSecretsManagerEKS"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "eks" {
  name        = "EKSReadPolicy"
  description = "EKS ListClusters and DescribeClusters"
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "eks:ListClusters",
        "eks:DescribeCluster"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "secretsmanager_read" {
  name        = "SecretsManagerRead"
  description = "Read policy for Secrets Manager"
  policy      = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetRandomPassword",
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "eks" {
  role       = aws_iam_role.secretsmanager_eks_sync.name
  policy_arn = aws_iam_policy.eks.arn
}

resource "aws_iam_role_policy_attachment" "cloudwatch" {
  role       = aws_iam_role.secretsmanager_eks_sync.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_role_policy_attachment" "secretsmanager" {
  role       = aws_iam_role.secretsmanager_eks_sync.name
  policy_arn = aws_iam_policy.secretsmanager_read.arn
}
