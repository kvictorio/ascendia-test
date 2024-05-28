variable "api_name" {
  type        = string
  description = "The name of the API Gateway"
}

variable "cognito_user_pool_arn" {
  type        = string
  description = "The ARN of the Cognito user pool used for authentication"
}

variable "s3_bucket_name" {
  type        = string
  description = "The S3 bucket name where the login page is stored"
}

variable "login_lambda_arn" {
  type        = string
  description = "ARN of the Lambda function for login processing"
}

variable "logout_lambda_arn" {
  type        = string
  description = "ARN of the Lambda function for logout processing"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resources"
}
