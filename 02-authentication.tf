module "route53" {
  source                  = "./modules/route53"
  domain_name             = "api.construction-site.com"
  hosted_zone_id          = "samplehostzoneid"
  bucket_name             = var.bucket_name
  api_gateway_domain_name = aws_api_gateway_domain_name.api_gateway_custom_domain.domain_name
  api_gateway_zone_id     = aws_api_gateway_domain_name.api_gateway_custom_domain.hosted_zone_id
  ttl_seconds             = 300
  tags                    = {
    Environment = "dev"
  }
}

module "cognito_user_pool" {
  source               = "./modules/cognito"
  user_pool_name       = "construction-site-user-pool"
  password_policy      = {
    minimum_length    = 10
    require_lowercase = true
    require_numbers   = true
    require_symbols   = true
    require_uppercase = true
  }
  auto_verified_attributes = ["email"]
  tags                 = {
    "Environment" = "dev"
    "Purpose"     = "User Authentication"
  }
}

module "api_gateway" {
  source = "./modules/api_gateway"
  api_name = "ConstructionSiteAPI"
  cognito_user_pool_arn = module.cognito.user_pool_arn
  s3_bucket_name = module.s3_login_page.bucket_name
  login_lambda_arn = module.lambda_sign_in.aws_lambda_function.this.arn
  logout_lambda_arn = module.lambda_sign_out.aws_lambda_function.this.arn
}
