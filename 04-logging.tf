module "cloudwatch_log_group_login" {
  source            = "./modules/cloudwatch_logs"
  log_group_name    = "construction-site-login-events"
  retention_in_days = 90
  tags              = {
    "Environment"   = "dev"
    "Purpose"       = "Login Events"
  }
}

module "cloudwatch_log_group_logout" {
  source            = "./modules/cloudwatch_logs"
  log_group_name    = "construction-site-logout-events"
  retention_in_days = 90
  tags              = {
    "Environment"   = "dev"
    "Purpose"       = "Logout Events"
  }
}