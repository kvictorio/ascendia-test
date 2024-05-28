import boto3
import os
from botocore.exceptions import ClientError

def lambda_handler(event, context):
    ses_client = boto3.client('ses')
    
    bucket_name = event['Records'][0]['s3']['bucket']['name']
    key = event['Records'][0]['s3']['object']['key']
    
    SENDER = os.environ.get('FROM_EMAIL')
    RECIPIENT = os.environ.get('TO_EMAIL')
    SUBJECT = "New PDF File Uploaded to S3"
    BODY_TEXT = (f"A new PDF file has been uploaded to the S3 bucket.\n\n"
                 f"Bucket: {bucket_name}\n"
                 f"File: {key}\n")
    CHARSET = "UTF-8"
    
    try:
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
