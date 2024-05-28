output "user_pool_id" {
  value       = aws_cognito_user_pool.main.id
  description = "The ID of the Cognito user pool"
}

output "user_pool_arn" {
  value       = aws_cognito_user_pool.main.arn
  description = "The ARN of the Cognito user pool"
}

output "user_pool_client_id" {
  value       = aws_cognito_user_pool_client.app_client.id
  description = "The ID of the Cognito user pool client"
}

output "user_pool_client_secret" {
  value       = aws_cognito_user_pool_client.app_client.client_secret
  description = "The client secret of the Cognito user pool client"
}
