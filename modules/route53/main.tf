resource "aws_route53_record" "api_gateway_dns" {
  zone_id = var.hosted_zone_id
  name    = var.domain_name
  type    = "A"
  ttl     = var.ttl_seconds

  alias {
    name                   = var.api_gateway_domain_name
    zone_id                = var.api_gateway_zone_id
    evaluate_target_health = true
  }
}
