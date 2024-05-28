output "lambda_function_name" {
  value       = aws_lambda_function.this.function_name
  description = "The name of the Lambda function"
}

output "lambda_function_arn" {
  value       = aws_lambda_function.this.arn
  description = "The ARN of the Lambda function"
}
