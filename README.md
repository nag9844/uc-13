# Hello World API with AWS Cognito Authentication

This Terraform configuration creates a simple Hello World API using AWS API Gateway, Lambda, and Cognito for authentication.

## Architecture

- **AWS Cognito**: User authentication and authorization
- **AWS API Gateway**: REST API endpoint with Cognito authorization
- **AWS Lambda**: Backend function that returns "Hello World"
- **CloudWatch**: Logging for Lambda function

## Prerequisites

1. AWS CLI configured with appropriate credentials
2. Terraform installed (>= 1.0)
3. Appropriate AWS permissions to create the resources

## Required AWS Permissions

Your AWS credentials need the following permissions:
- IAM (roles, policies)
- Lambda (functions, permissions)
- API Gateway (REST APIs, methods, deployments)
- Cognito (user pools, clients)
- CloudWatch (log groups)

## Deployment

1. **Initialize Terraform:**
   ```bash
   cd terraform
   terraform init
   ```

2. **Plan the deployment:**
   ```bash
   terraform plan
   ```

3. **Apply the configuration:**
   ```bash
   terraform apply
   ```

4. **Note the outputs:** After successful deployment, note the following outputs:
   - `api_gateway_url`: The URL to test your API
   - `cognito_user_pool_id`: User Pool ID
   - `cognito_user_pool_client_id`: Client ID for authentication
   - `test_user_info`: Test user credentials

## Testing the API

### Method 1: Using AWS CLI (Recommended)

1. **Authenticate and get tokens:**
   ```bash
   aws cognito-idp admin-initiate-auth \
     --user-pool-id <USER_POOL_ID> \
     --client-id <CLIENT_ID> \
     --auth-flow ADMIN_NO_SRP_AUTH \
     --auth-parameters USERNAME=testuser,PASSWORD=TempPassword123! \
     --region <AWS_REGION>
   ```

2. **Use the ID token to call the API:**
   ```bash
   curl -H "Authorization: <ID_TOKEN>" <API_GATEWAY_URL>
   ```

### Method 2: Using Postman or Similar Tool

1. First, get an access token by making a POST request to Cognito
2. Use the token in the Authorization header when calling the API Gateway URL

### Method 3: Without Authentication (Should Fail)

```bash
curl <API_GATEWAY_URL>
```

This should return a 401 Unauthorized error.

## Test User

A test user is automatically created with:
- **Username**: `testuser`
- **Email**: `test@example.com`
- **Temporary Password**: `TempPassword123!`

**Note**: You'll need to change the password on first login.

## File Structure

```
terraform/
├── main.tf              # Main Terraform configuration
├── variables.tf         # Input variables
├── outputs.tf           # Output values
├── cognito.tf          # Cognito resources
├── lambda.tf           # Lambda function and related resources
├── api-gateway.tf      # API Gateway configuration
├── iam.tf              # IAM roles and policies
├── lambda/
│   └── hello_world.py  # Lambda function code
└── README.md           # This file
```

## Customization

You can customize the deployment by modifying the variables in `variables.tf` or by passing them during terraform apply:

```bash
terraform apply -var="aws_region=us-west-2" -var="project_name=my-hello-world"
```

## Clean Up

To destroy all resources:

```bash
terraform destroy
```

## Security Considerations

- The test user is created for development purposes only
- In production, remove the test user creation
- Consider implementing more sophisticated password policies
- Enable MFA for production environments
- Review and adjust IAM permissions as needed

## Troubleshooting

1. **403 Forbidden**: Check that you're using the correct ID token in the Authorization header
2. **500 Internal Server Error**: Check CloudWatch logs for the Lambda function
3. **Resource conflicts**: Ensure resource names are unique in your AWS account

## Cost Considerations

This setup uses AWS services that may incur costs:
- Lambda: Pay per request and compute time
- API Gateway: Pay per API call
- Cognito: Free tier available, then pay per MAU
- CloudWatch: Pay for log storage and queries

Most usage for development/testing will fall within AWS free tier limits.