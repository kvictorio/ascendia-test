resource "aws_sns_topic" "sns_topic" {
  name = var.topic_name

  tags = var.tags
}

resource "aws_sns_topic_policy" "sns_topic_policy" {
  arn    = aws_sns_topic.sns_topic.arn
  policy = data.aws_iam_policy_document.sns_policy.json
}

data "aws_iam_policy_document" "sns_policy" {
  statement {
    actions   = ["SNS:Publish"]
    effect    = "Allow"
    resources = [aws_sns_topic.sns_topic.arn]

    principals {
      type        = "Service"
      identifiers = ["sns.amazonaws.com"]
    }
  }
}

resource "aws_sns_topic_subscription" "sms_subscription" {
  topic_arn = aws_sns_topic.sns_topic.arn
  protocol  = "sms"
  endpoint  = var.phone_number
}

resource "aws_sns_sms_preferences" "sms_preferences" {
  count = var.display_name != "" ? 1 : 0

  default_sender_id = var.display_name
}
