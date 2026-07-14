resource "aws_eks_cluster" "this" {

  name     = local.name_prefix
  version  = var.cluster_version
  role_arn = var.cluster_role_arn

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_config {

    subnet_ids = var.private_subnet_ids

    endpoint_private_access = true
    endpoint_public_access  = true

    security_group_ids = [
      var.cluster_security_group_id
    ]
  }

  encryption_config {

    provider {
      key_arn = var.kms_key_arn
    }

    resources = [
      "secrets"
    ]
  }

  tags = merge(
    local.common_tags,
    {
      Name              = local.name_prefix
      KubernetesCluster = local.name_prefix
    }
  )
}

resource "aws_eks_node_group" "default" {

  cluster_name = aws_eks_cluster.this.name

  node_group_name = "${local.name_prefix}-system"

  node_role_arn = var.node_role_arn

  subnet_ids = var.private_subnet_ids

  capacity_type = "ON_DEMAND"

  instance_types = [
    "t3.medium"
  ]

  scaling_config {

    desired_size = 1
    min_size     = 1
    max_size     = 5
  }

  update_config {
    max_unavailable = 1
  }

  depends_on = [
    aws_eks_cluster.this
  ]

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-system"
    }
  )
}

resource "aws_iam_openid_connect_provider" "eks" {

  client_id_list = [
    "sts.amazonaws.com"
  ]

  thumbprint_list = [
    data.tls_certificate.eks.certificates[0].sha1_fingerprint
  ]

  url = aws_eks_cluster.this.identity[0].oidc[0].issuer

  tags = local.common_tags
}