resource "aws_iam_role" "karpenter_controller" {

  name = "${var.project_name}-${var.environment}-karpenter-controller-role"

  assume_role_policy = jsonencode({

    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Federated = data.terraform_remote_state.eks.outputs.oidc_provider_arn
        }

        Action = "sts:AssumeRoleWithWebIdentity"

        Condition = {
          StringEquals = {

            "${replace(data.terraform_remote_state.eks.outputs.oidc_issuer_url, "https://", "")}:sub" = "system:serviceaccount:karpenter:karpenter"

            "${replace(data.terraform_remote_state.eks.outputs.oidc_issuer_url, "https://", "")}:aud" = "sts.amazonaws.com"
          }
        }
      }
    ]
  })
}