module "ses_email_notification" {
  source = "./modules/ses"  

  from_email      = "sender@example.com"
  manager_email   = "manager@example.com"
  s3_bucket_name  = module.s3_pdf_storage_login.bucket_name
}


module "sns_logout_notifications" {
  topic_name           = "logout_event"
  source               = "./modules/sns"
  phone_number         = "+1234567890"
  tags                 = {
    "Environment"      = "dev"
    "Purpose"          = "Logout Notifications"
  }
}

module "s3_pdf_storage_login" {
  source                 = "./modules/s3"
  bucket_name            = "construction-site-pdfs"
  pdf_notification_email = "site.supervisor@sample.com"
}
