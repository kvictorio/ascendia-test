variable "from_email" {
  type        = string
  description = "Email address used as the sender in SES"
}

variable "s3_bucket_name" {
  type        = string
  description = "The name of the S3 bucket where PDF files are stored"
}

variable "manager_email" {
  type        = string
  description = "Manager's email address to send notifications to"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Tags to assign to the SES resources"
}
