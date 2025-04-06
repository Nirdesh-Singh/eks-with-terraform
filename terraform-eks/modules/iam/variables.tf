variable "region" {
  description = "AWS region"
  type        = string
}

variable "oidc_provider_arn" {
  description = "OIDC provider ARN for IAM roles"
  type        = string
}

variable "account_id" {
  description = "AWS account ID where the IAM role will be created"
  type        = string
}

