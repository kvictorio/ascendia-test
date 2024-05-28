variable "hosted_zone_id" {
  type        = string
  description = "The ID of the Route 53 hosted zone where the record will be created"
}

variable "domain_name" {
  type        = string
  description = "The full domain name to configure, e.g., 'api.example.com'"
}

variable "api_gateway_domain_name" {
  type        = string
  description = "The domain name of the API Gateway"
}

variable "api_gateway_zone_id" {
  type        = string
  description = "The hosted zone ID specific to the API Gateway or CloudFront distribution"
}
