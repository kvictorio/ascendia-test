variable "domain_name" {
  type        = string
  description = "The domain name for which the DNS record will be created"
}

variable "hosted_zone_id" {
  type        = string
  description = "The ID of the Route 53 hosted zone where the record will be created"
}

variable "api_gateway_domain_name" {
  type        = string
  description = "The domain name of the API Gateway deployment"
}

variable "api_gateway_zone_id" {
  type        = string
  description = "The Zone ID of the API Gateway custom domain"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A mapping of tags to assign to the Route 53 DNS record"
}

variable "ttl_seconds" {
  type        = number
  default     = {}
  description = "Amount of seconds for time out"
}