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
