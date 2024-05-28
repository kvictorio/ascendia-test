## API Gateway Vars
variable "api_name" {
  type        = string
  description = "The name of the API Gateway API"
}

variable "cognito_user_pool_arn" {
  type        = string
  description = "The ARN of the Cognito User Pool for authentication"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket to store the static login page"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resources"
}

## Cognito Vars

variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito user pool"
}

variable "password_policy" {
  type        = map(any)
  description = "Password policy for the Cognito user pool"
  default     = {
    minimum_length    = 8
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }
}

variable "auto_verified_attributes" {
  type        = list(string)
  default     = ["email"]
  description = "Attributes to be auto-verified by Cognito"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the Cognito user pool"
}

##Cloudwatch Vars
variable "log_group_name" {
  type        = string
  description = "The name of the CloudWatch log group"
}

variable "retention_in_days" {
  type        = number
  default     = 30
  description = "The number of days to retain log events in the specified log group"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource"
}

## Lambda Vars

variable "function_name" {
  type        = string
  description = "The name of the Lambda function"
}

variable "handler" {
  type        = string
  description = "The handler for the Lambda function"
}

variable "runtime" {
  type        = string
  description = "The runtime environment for the Lambda function"
}

variable "s3_bucket" {
  type        = string
  default     = ""
  description = "S3 bucket to which the Lambda function should have access"
}

variable "sns_topic_arn" {
  type        = string
  default     = ""
  description = "ARN of the SNS topic for sending notifications"
}

variable "log_group_name" {
  type        = string
  description = "The name of the CloudWatch log group where logs should be directed"
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the Lambda function"
}


## S3 Vars
variable "bucket_name" {
  type        = string
  description = "The name of the S3 bucket"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the bucket"
}

variable "enable_versioning" {
  type        = bool
  default     = false
  description = "Specifies whether to enable versioning"
}

variable "pdf_notification_email" {
  type        = string
  default     = ""
  description = "Email address to notify when a PDF is uploaded. Leave empty if not applicable."
}

variable "sns_topic_arn" {
  type        = string
  default     = ""
  description = "ARN of the SNS topic to publish S3 events"
}

## SES Vars

variable "from_email" {
  type        = string
  description = "Email address from which the notification emails will be sent"
}

variable "to_email" {
  type        = string
  description = "Email address to which the notification emails will be sent"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where PDF files are stored"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the resource"
}

## SNS Vars

variable "topic_name" {
  type        = string
  description = "The name of the SNS topic"
}

variable "display_name" {
  type        = string
  default     = ""
  description = "The display name for the SMS messages sent from this SNS topic"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the SNS topic"
}

variable "phone_number" {
  type        = string
  default     = "replace this value"
  description = "phone number of the receiving manager"
}
