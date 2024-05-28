output "ses_identity_arn" {
  value       = aws_ses_email_identity.email_identity.arn
  description = "The ARN of the SES email identity"
}
