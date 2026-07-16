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

module "alb_controller_irsa" {

  source = "../../../modules/irsa"

  role_name = "${var.project_name}-${var.environment}-alb-controller-role"

  oidc_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn

  oidc_provider_url = data.terraform_remote_state.eks.outputs.oidc_issuer_url

  namespace = "kube-system"

  service_account_name = "aws-load-balancer-controller"

  policy_arns = [
    "arn:aws:iam::219834006508:policy/retail-platform-dev-alb-controller-policy"
  ]
}

module "external_dns_irsa" {

  source = "../../../modules/irsa"

  role_name = "${var.project_name}-${var.environment}-external-dns-role"

  oidc_provider_arn = data.terraform_remote_state.eks.outputs.oidc_provider_arn

  oidc_provider_url = data.terraform_remote_state.eks.outputs.oidc_issuer_url

  namespace = "external-dns"

  service_account_name = "external-dns"

  policy_arns = [
    "arn:aws:iam::219834006508:policy/retail-platform-dev-external-dns-policy"
  ]
}