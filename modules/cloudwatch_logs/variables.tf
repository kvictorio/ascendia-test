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
