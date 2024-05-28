resource "aws_cognito_user_pool" "main" {
  name = var.user_pool_name

  password_policy {
    minimum_length    = var.password_policy.minimum_length
    require_lowercase = var.password_policy.require_lowercase
    require_numbers   = var.password_policy.require_numbers
    require_symbols   = var.password_policy.require_symbols
    require_uppercase = var.password_policy.require_uppercase
  }

  auto_verified_attributes = var.auto_verified_attributes

  tags = var.tags
}

resource "aws_cognito_user_pool_client" "app_client" {
  name         = "${var.user_pool_name}-app-client"
  user_pool_id = aws_cognito_user_pool.main.id

  generate_secret = true

  # Define allowed OAuth flows and scopes if needed
  allowed_oauth_flows = ["code", "implicit"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes = ["email", "openid", "profile"]

  callback_urls = ["https://example.com/callback"]
  logout_urls   = ["https://example.com/logout"]
}
