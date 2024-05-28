resource "aws_ses_email_identity" "email_identity" {
  email = var.from_email
}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_for_ses_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      },
      {
        Effect = "Allow"
        Principal = {
          Service = "s3.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_role_policy" "lambda_policy" {
  role = aws_iam_role.lambda_exec_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "logs:*",
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_lambda_function" "ses_trigger" {
  function_name = "send_email_on_pdf_upload"
  handler       = "lambda_function.handler"
  runtime       = "python3.8"
  role          = aws_iam_role.lambda_exec_role.arn
  filename      = "./function/lambda_emailer.zip"

  environment {
    variables = {
      FROM_EMAIL = var.from_email
      TO_EMAIL   = var.manager_email
      S3_BUCKET  = var.s3_bucket_name
    }
  }

  tags = var.tags
}

resource "aws_lambda_permission" "allow_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.ses_trigger.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = "arn:aws:s3:::${var.s3_bucket_name}"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = var.s3_bucket_name

  lambda_function {
    lambda_function_arn = aws_lambda_function.ses_trigger.arn
    events              = ["s3:ObjectCreated:*"]
    filter_prefix       = "/"
    filter_suffix       = ".pdf"
  }
}
