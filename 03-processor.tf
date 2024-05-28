module "lambda_sign_in" {
  source                = "./modules/lambda"
  function_name         = "SignInFunction"
  handler               = "sign-in.handler"
  runtime               = "python3.8"
  log_group_name        = module.cloudwatch_log_group_login.log_group_name
  source_code_path      = "assets/sign-in.py"
  environment_variables = {
    S3_BUCKET = module.s3_pdf_storage.bucket_name
  }
  tags                 = {
    Purpose = "Handle SignIn Events"
  }
}

module "lambda_sign_out" {
  source                = "./modules/lambda"
  function_name         = "SignOutFunction"
  handler               = "sign-out.handler"
  runtime               = "python3.8"
  log_group_name        = module.cloudwatch_log_group_logout.log_group_name
  sns_topic_arn         = module.sns_logout_notifications.sns_topic_arn
  source_code_path      = "assets/sign-out.py"
  tags                 = {
    Purpose = "Handle SignOut Events"
  }
}