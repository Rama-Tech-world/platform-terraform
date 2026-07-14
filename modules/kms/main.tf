data "aws_caller_identity" "current" {}

data "aws_iam_policy_document" "kms_key_policy" {

  statement {

    sid = "EnableRootPermissions"

    effect = "Allow"

    principals {

      type = "AWS"

      identifiers = [
        "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      ]
    }

    actions = [
      "kms:*"
    ]

    resources = [
      "*"
    ]
  }
}

resource "aws_kms_key" "eks" {

  description = "KMS key for EKS secret encryption"

  enable_key_rotation = true

  deletion_window_in_days = 30

  policy = data.aws_iam_policy_document.kms_key_policy.json

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-key"
    }
  )
}

resource "aws_kms_alias" "eks" {

  name = "alias/${local.name_prefix}-eks-key"

  target_key_id = aws_kms_key.eks.key_id
}

