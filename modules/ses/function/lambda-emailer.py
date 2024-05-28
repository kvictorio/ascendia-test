import boto3
import os
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    # Initialize SES client
    ses_client = boto3.client('ses')
    
    # Extract bucket name and file key from the S3 event
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    # Email details
    SENDER = os.environ.get('FROM_EMAIL')
    RECIPIENT = os.environ.get('TO_EMAIL')
    SUBJECT = "New PDF File Uploaded to S3"
    BODY_TEXT = (f"A new PDF file has been uploaded to the S3 bucket.\n\n"
                 f"Bucket: {bucket_name}\n"
                 f"File: {key}\n")
    CHARSET = "UTF-8"
    
    # Try to send the email.
    try:
        # Provide the contents of the email.
        response = ses_client.send_email(
            Destination={
                'ToAddresses': [
                    RECIPIENT,
                ],
            },
            Message={
                'Body': {
                    'Text': {
                        'Charset': CHARSET,
                        'Data': BODY_TEXT,
                    },
                },
                'Subject': {
                    'Charset': CHARSET,
                    'Data': SUBJECT,
                },
            },
            Source=SENDER,
        )
    except ClientError as e:
        print(e.response['Error']['Message'])
    else:
        print("Email sent! Message ID:"),
        print(response['MessageId'])

    return {
        'statusCode': 200,
        'body': "Email sent successfully!"
    }
