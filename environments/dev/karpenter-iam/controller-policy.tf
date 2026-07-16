resource "aws_iam_policy" "karpenter_controller" {

  name = "${var.project_name}-${var.environment}-karpenter-controller-policy"

  policy = jsonencode({

    Version = "2012-10-17"

    Statement = [

      {
        Sid    = "AllowEC2Read"
        Effect = "Allow"

        Action = [
          "ec2:DescribeAvailabilityZones",
          "ec2:DescribeImages",
          "ec2:DescribeInstances",
          "ec2:DescribeInstanceTypeOfferings",
          "ec2:DescribeInstanceTypes",
          "ec2:DescribeLaunchTemplates",
          "ec2:DescribeSecurityGroups",
          "ec2:DescribeSubnets",
          "ec2:DescribeSpotPriceHistory",
          "ec2:DescribeVolumes",
          "ec2:DescribeVpcs"
        ]

        Resource = "*"
      },

      {
        Sid    = "AllowEC2Create"
        Effect = "Allow"

        Action = [
          "ec2:RunInstances",
          "ec2:CreateLaunchTemplate",
          "ec2:CreateFleet"
        ]

        Resource = "*"
      },

      {
        Sid    = "AllowEC2Delete"
        Effect = "Allow"

        Action = [
          "ec2:TerminateInstances",
          "ec2:DeleteLaunchTemplate"
        ]

        Resource = "*"
      },

      {
        Sid    = "AllowPassNodeRole"
        Effect = "Allow"

        Action = [
          "iam:PassRole"
        ]

        Resource = aws_iam_role.karpenter_node.arn
      },

      {
        Sid    = "AllowPricing"
        Effect = "Allow"

        Action = [
          "pricing:GetProducts"
        ]

        Resource = "*"
      },

      {
        Sid    = "AllowSSM"
        Effect = "Allow"

        Action = [
          "ssm:GetParameter"
        ]

        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "karpenter_controller" {

  role = aws_iam_role.karpenter_controller.name

  policy_arn = aws_iam_policy.karpenter_controller.arn
}