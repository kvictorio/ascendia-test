module "route53" {
  source                  = "./modules/route53"
  domain_name             = "api.construction-site.com"
  hosted_zone_id          = "samplehostzoneid"
  api_gateway_domain_name = module.api_gateway.api_gateway_domain_name
  api_gateway_zone_id     = module.api_gateway.api_gateway_zone_id
}


module "cognito" {
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
  custom_domain_name      = "testdomain"
  ssl_certificate_arn     = "samplesslcert"
  cognito_user_pool_arn   = module.cognito.user_pool_arn
  s3_bucket_name          = module.s3_login_page.bucket_name
  login_lambda_arn        = module.lambda_sign_in.lambda_function_arn
  logout_lambda_arn       = module.lambda_sign_out.lambda_function_arn
}

module "s3_login_page" {
  source                 = "./modules/s3"
  bucket_name            = "website-front-page"
}