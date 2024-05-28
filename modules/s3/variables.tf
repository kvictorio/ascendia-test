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
