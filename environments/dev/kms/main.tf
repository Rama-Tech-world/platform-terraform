module "kms" {

  source = "../../../modules/kms"

  project_name = var.project_name
  environment  = var.environment
}