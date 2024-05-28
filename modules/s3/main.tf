resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket_name
  tags = var.tags
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.bucket.id
  key    = "index.html"
  source = "../src/index.html"
  acl    = "public-read"
}

resource "aws_s3_bucket_notification" "bucket_notification" {
  bucket = aws_s3_bucket.bucket.id

  dynamic "lambda_function" {
    for_each = var.pdf_notification_email != "" ? [1] : []
    content {
      lambda_function_arn = var.sns_topic_arn
      events              = ["s3:ObjectCreated:*"]
      filter_prefix       = "documents/"
      filter_suffix       = ".pdf"
    }
  }
}

