## Default Tags

variable "tags" {
  type        = map(string)
  description = "Default Tags"
  default     = {
    Environment    = "dev"
    Platform       = "Construction Site"
  }
}

## API Gateway Vars
variable "api_name" {
  type        = string
  description = "The name of the API Gateway API"
  default     = "construction-api"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store the static login page"
  default     = "construction-s3bucket"
}

variable "custom_domain_name" {
  type        = string
  description = "custom domain name"
  default     = "construction-domain-name"
}

variable "ssl_certificate_arn" {
  type        = string
  description = "SSL Certificate"
  default     = "construction-sslcert"
}

## Cognito Vars

variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito user pool"
  default     = "cognito-userpoolname"
}

variable "password_policy" {
  type        = map(string)
  description = "Password policy for the Cognito user pool"
  default     = {
    minimum_length    = "8"
    require_lowercase = "true"
    require_numbers   = "true"
    require_symbols   = "true"
    require_uppercase = "true"
  }
}

variable "auto_verified_attributes" {
  type        = list(string)
  default     = ["email"]
  description = "Attributes to be auto-verified by Cognito"
}


##Cloudwatch Vars
variable "log_group_name" {
  type        = string
  description = "The name of the CloudWatch log group"
  default     = "construction-site-loggroup"
}

variable "retention_in_days" {
  type        = number
  default     = 90
  description = "The number of days to retain log events in the specified log group"
}

## Lambda Vars

variable "function_name" {
  type        = string
  description = "The name of the Lambda function"
  default     = "construction-site-lambda"
}

variable "handler" {
  type        = string
  description = "The handler for the Lambda function"
  default     = "handler.handler"
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function"
  default     = "python3.8"
}

variable "s3_bucket" {
  type        = string
  default     = "s3_bucket"
  description = "S3 bucket to which the Lambda function should have access"
}

variable "source_code_path" {
  type        = string
  description = "Path to the Lambda function's source code"
}

variable "environment_variables" {
  type        = map(string)
  default     = {}
  description = "Environment variables to pass to the Lambda function"
}

## S3 Vars
variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "enable_versioning" {
  type        = bool
  default     = false
  description = "Specifies whether to enable versioning"
}

variable "pdf_notification_email" {
  type        = string
  default     = ""
  description = "Email address to notify when a PDF is uploaded."
}

## SES Vars

variable "from_email" {
  type        = string
  description = "The email address used as the sender in SES."
  default     = "manager@ascendia.com"
}

## SNS Vars

variable "topic_name" {
  type        = string
  description = "The name of the SNS topic"
  default     = "construction-site-logout"
}

variable "display_name" {
  type        = string
  default     = "AutoMailer"
  description = "The display name for the SMS messages sent from this SNS topic"
}

variable "phone_number" {
  type        = string
  default     = "replace this value"
  description = "phone number of the receiving manager"
}
