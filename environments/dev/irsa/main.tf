module "external_secrets_irsa" {

  source = "../../../modules/irsa"

  role_name = "${var.project_name}-${var.environment}-external-secrets-role"

  oidc_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn

  oidc_provider_url = data.terraform_remote_state.eks.outputs.oidc_issuer_url

  namespace = "external-secrets"

  service_account_name = "external-secrets"

  policy_arns = [
    "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
  ]
}