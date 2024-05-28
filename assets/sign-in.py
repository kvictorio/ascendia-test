import json
import boto3
import os

s3 = boto3.client('s3')
ses = boto3.client('ses')

def handler(event, context):
    user_details = event['details']
    pdf_content = create_pdf(user_details)
    pdf_filename = f"{user_details['user_id']}.pdf"

    # Save PDF to S3
    s3.put_object(
        Bucket=os.environ['S3_BUCKET'],
        Key=f"documents/{pdf_filename}",
        Body=pdf_content,
        ContentType='application/pdf'
    )

    # Send an email with the PDF link
    response = ses.send_email(
        Source='no-reply@example.com',
        Destination={
            'ToAddresses': ['site.supervisor@example.com']
        },
        Message={
            'Subject': {
                'Data': 'New Sign-In at Construction Site'
            },
            'Body': {
                'Text': {
                    'Data': f"A new sign-in occurred. Details attached in the PDF: {pdf_filename}"
                }
            }
        }
    )

    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Sign-in processed successfully'})
    }

def create_pdf(user_details):
    # Placeholder for PDF creation logic
    return b"PDF content of user details here"
