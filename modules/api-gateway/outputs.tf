output "api_gateway_url" {
  value       = "https://${aws_api_gateway_rest_api.api.execution_arn}/prod/login"
  description = "The URL of the API Gateway endpoint for the login page"
}

output "s3_bucket_website_endpoint" {
  value       = aws_s3_bucket.login_page_bucket.website_endpoint
  description = "The website endpoint for the S3 bucket hosting the login page"
}
