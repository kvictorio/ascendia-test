module "ses_email_notifications" {
  source          = "./modules/ses"
  from_email      = "noreply@example.com"
  to_email        = "site.supervisor@example.com"
  s3_bucket_name  = "construction-site-pdfs"
  tags            = {
    "Environment" = "dev"
    "Purpose"     = "SES Notifications"
  }
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
  tags                   = {
    "Environment"        = "dev"
    "Content"            = "PDFs"
  }
}
