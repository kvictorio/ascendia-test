import json
import boto3
import os

sns = boto3.client('sns')

def handler(event, context):
    user_details = event['details']

    response = sns.publish(
        PhoneNumber=os.environ['MANAGER_PHONE_NUMBER'],
        Message=f"User {user_details['user_name']} has signed out from the construction site."
    )

    return {
        'statusCode': 200,
        'body': json.dumps({'message': 'Sign-out processed successfully'})
    }
