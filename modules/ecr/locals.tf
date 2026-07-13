locals {

  common_tags = {

    Project     = var.project_name
    Environment = var.environment
    ManagedBy   = "Terraform"
    Repository  = "platform-terraform"
  }

  repositories = [

    "frontend",
    "product-service",
    "order-service",
    "payment-service",
    "user-service"
  ]
}