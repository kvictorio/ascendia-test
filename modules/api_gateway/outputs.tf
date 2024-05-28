output "api_gateway_url" {
  value       = "https://${aws_api_gateway_rest_api.api.execution_arn}/prod/login"
  description = "The URL of the API Gateway endpoint for the login page"
}

output "s3_bucket_website_endpoint" {
  value       = aws_s3_bucket.login_page_bucket.website_endpoint
  description = "The website endpoint for the S3 bucket hosting the login page"
}

output "api_gateway_domain_name" {
  description = "the API Gateway domain name"
  value = aws_api_gateway_domain_name.api_gateway_custom_domain.domain_name
}

output "api_gateway_zone_id" {
  description = "The hosted zone ID of the regional API Gateway custom domain."
  value       = aws_api_gateway_domain_name.api_gateway_custom_domain.regional_zone_id
}

