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
