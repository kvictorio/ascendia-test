output "route53_record_name" {
  value       = aws_route53_record.api_gateway_dns.name
  description = "The DNS record name for the API Gateway endpoint"
}

output "route53_record_zone_id" {
  value       = var.hosted_zone_id
  description = "The Route 53 hosted zone ID where the record is created"
}
