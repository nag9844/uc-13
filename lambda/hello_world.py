import json
import logging

# Configure logging
logger = logging.getLogger()
logger.setLevel(logging.INFO)

def lambda_handler(event, context):
    """
    Lambda function to return Hello World HTML page
    """
    try:
        # Log the incoming event
        logger.info(f"Received event: {json.dumps(event)}")
        
        # Extract user information from the event context
        username = "Unknown"
        email = "No email"
        
        if 'requestContext' in event and 'authorizer' in event['requestContext']:
            claims = event['requestContext']['authorizer'].get('claims', {})
            username = claims.get('cognito:username', 'Unknown')
            email = claims.get('email', 'No email')
        
        # Create simple HTML response
        html_content = f"""
        <!DOCTYPE html>
        <html>
        <head>
            <title>Hello World</title>
        </head>
        <body>
            <h1>Hello World!</h1>
            <p>Welcome, {username}!</p>
            <p>Email: {email}</p>
            <p>You have successfully authenticated and accessed the Hello World page.</p>
            <p>Request ID: {context.aws_request_id}</p>
        </body>
        </html>
        """
        
        # Return HTML response
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'text/html',
                'Access-Control-Allow-Origin': '*',
                'Access-Control-Allow-Methods': 'GET, POST, OPTIONS',
                'Access-Control-Allow-Headers': 'Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token'
            },
            'body': html_content
        }
        
    except Exception as e:
        logger.error(f"Error processing request: {str(e)}")
        
        # Return error HTML response
        error_html = f"""
        <!DOCTYPE html>
        <html>
        <head>
            <title>Error</title>
        </head>
        <body>
            <h1>Error</h1>
            <p>Something went wrong: {str(e)}</p>
        </body>
        </html>
        """
        
        return {
            'statusCode': 500,
            'headers': {
                'Content-Type': 'text/html',
                'Access-Control-Allow-Origin': '*'
            },
            'body': error_html
        }