resource "aws_lambda_function" "this" {
  function_name = var.function_name
  handler       = var.handler
  runtime       = var.runtime
  role          = aws_iam_role.lambda_role.arn
  filename      = var.source_code_path

  environment {
    variables = var.environment_variables
  }

  tags = var.tags
}

resource "aws_iam_role" "lambda_role" {
  name = "${var.function_name}_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy" "lambda_policy" {
  role   = aws_iam_role.lambda_role.id
  policy = data.aws_iam_policy_document.lambda_policy_doc.json
}

data "aws_iam_policy_document" "lambda_policy_doc" {
  statement {
    actions   = ["logs:CreateLogStream", "logs:PutLogEvents"]
    resources = ["arn:aws:logs:*:*:log-group:${var.log_group_name}:*"]
    effect    = "Allow"
  }

  statement {
    actions   = ["s3:GetObject", "s3:PutObject"]
    resources = ["arn:aws:s3:::${var.s3_bucket}/*"]
    effect    = "Allow"
    condition {
      test     = "StringEquals"
      variable = "s3:prefix"
      values   = ["documents/"]
    }
  }

  statement {
    actions   = ["sns:Publish"]
    resources = [var.sns_topic_arn]
    effect    = "Allow"
  }
}
