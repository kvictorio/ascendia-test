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