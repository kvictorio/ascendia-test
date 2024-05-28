resource "aws_s3_bucket" "login_page_bucket" {
  bucket = var.s3_bucket_name
  tags = var.tags
}

resource "aws_s3_object" "index" {
  bucket = aws_s3_bucket.login_page_bucket.id
  key    = "index.html"
  source = "./assets/index.html"
  acl    = "public-read"
}

resource "aws_api_gateway_rest_api" "api" {
  name        = var.api_name
  description = "API Gateway for handling login and logout events"
  tags        = var.tags
}

resource "aws_api_gateway_authorizer" "cognito_authorizer" {
  name          = "CognitoAuthorizer"
  rest_api_id   = aws_api_gateway_rest_api.api.id
  type          = "COGNITO_USER_POOLS"
  provider_arns = [var.cognito_user_pool_arn]
  identity_source = "method.request.header.Authorization"
}

resource "aws_api_gateway_resource" "login_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "login"
}

resource "aws_api_gateway_method" "login_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.login_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "login_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.login_resource.id
  http_method             = aws_api_gateway_method.login_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.login_lambda_arn
}

resource "aws_api_gateway_resource" "logout_resource" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  parent_id   = aws_api_gateway_rest_api.api.root_resource_id
  path_part   = "logout"
}

resource "aws_api_gateway_method" "logout_method" {
  rest_api_id   = aws_api_gateway_rest_api.api.id
  resource_id   = aws_api_gateway_resource.logout_resource.id
  http_method   = "POST"
  authorization = "COGNITO_USER_POOLS"
  authorizer_id = aws_api_gateway_authorizer.cognito_authorizer.id
}

resource "aws_api_gateway_integration" "logout_integration" {
  rest_api_id             = aws_api_gateway_rest_api.api.id
  resource_id             = aws_api_gateway_resource.logout_resource.id
  http_method             = aws_api_gateway_method.logout_method.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = var.logout_lambda_arn
}

resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.api.id
  stage_name  = "prod"
  depends_on = [
    aws_api_gateway_integration.login_integration,
    aws_api_gateway_integration.logout_integration
  ]
}

resource "aws_api_gateway_domain_name" "api_gateway_custom_domain" {
  domain_name              = var.custom_domain_name  # Ensure this variable is defined in your variables.tf
  certificate_arn          = var.ssl_certificate_arn  # Ensure this variable is defined; it's the ARN of an ACM certificate

  endpoint_configuration {
    types = ["REGIONAL"]
  }
}
