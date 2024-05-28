variable "user_pool_name" {
  type        = string
  description = "The name of the Cognito user pool"
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

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the Cognito user pool"
}
