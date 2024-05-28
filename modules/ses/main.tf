resource "aws_ses_email_identity" "email_identity" {
  email = var.from_email
}

resource "aws_iam_role" "ses_notification_role" {
  name = "ses_notification_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ses.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = var.tags
}

resource "aws_iam_policy" "ses_send_policy" {
  name = "ses_send_policy"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "ses:SendEmail",
          "ses:SendRawEmail"
        ]
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ses_policy_attachment" {
  role       = aws_iam_role.ses_notification_role.name
  policy_arn = aws_iam_policy.ses_send_policy.arn
}

resource "aws_ses_event_destination" "s3_event_destination" {
  name                   = "S3EventDestination"
  configuration_set_name = aws_ses_configuration_set.ses_config_set.name
  enabled                = true

  matching_types = ["send"]

  s3 {
    bucket_arn = "arn:aws:s3:::${var.s3_bucket_name}"
    topic_arn  = aws_sns_topic.ses_notifications.arn
  }
}

resource "aws_ses_configuration_set" "ses_config_set" {
  name = "SESEmailSendingConfig"
}
