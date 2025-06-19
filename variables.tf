variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Name of the project"
  type        = string
  default     = "hello-world-app"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "dev"
}

variable "cognito_user_pool_name" {
  description = "Name for the Cognito User Pool"
  type        = string
  default     = "hello-world-user-pool"
}

variable "api_gateway_name" {
  description = "Name for the API Gateway"
  type        = string
  default     = "hello-world-api"
}

variable "lambda_function_name" {
  description = "Name for the Lambda function"
  type        = string
  default     = "hello-world-function"
}