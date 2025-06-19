# API Gateway URL
output "api_gateway_url" {
  description = "API Gateway URL for the Hello World endpoint"
  value       = "${aws_api_gateway_stage.main.invoke_url}/hello"
}

# API Gateway Base URL
output "api_gateway_base_url" {
  description = "API Gateway base URL"
  value       = aws_api_gateway_stage.main.invoke_url
}

# Cognito User Pool ID
output "cognito_user_pool_id" {
  description = "Cognito User Pool ID"
  value       = aws_cognito_user_pool.main.id
}

# Cognito User Pool Client ID
output "cognito_user_pool_client_id" {
  description = "Cognito User Pool Client ID"
  value       = aws_cognito_user_pool_client.main.id
}

# Cognito User Pool Client Secret
output "cognito_user_pool_client_secret" {
  description = "Cognito User Pool Client Secret"
  value       = aws_cognito_user_pool_client.main.client_secret
  sensitive   = true
}

# Cognito User Pool Domain
output "cognito_user_pool_arn" {
  description = "Cognito User Pool ARN"
  value       = aws_cognito_user_pool.main.arn
}

# Lambda Function Name
output "lambda_function_name" {
  description = "Lambda function name"
  value       = aws_lambda_function.hello_world.function_name
}

# Lambda Function ARN
output "lambda_function_arn" {
  description = "Lambda function ARN"
  value       = aws_lambda_function.hello_world.arn
}

# Test User Credentials
output "test_user_info" {
  description = "Test user information"
  value = {
    username = aws_cognito_user.test_user.username
    email    = "test@example.com"
    note     = "Use temporary password 'TempPassword123!' and change on first login"
  }
}

# AWS Region
output "aws_region" {
  description = "AWS region"
  value       = var.aws_region
}