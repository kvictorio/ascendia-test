output "bucket_name" {
  value       = aws_s3_bucket.bucket.bucket
  description = "The name of the S3 bucket"
}

output "bucket_arn" {
  value       = aws_s3_bucket.bucket.arn
  description = "The ARN of the S3 bucket"
}
