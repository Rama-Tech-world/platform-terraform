resource "aws_eks_access_entry" "platform_bootstrap" {

  cluster_name  = aws_eks_cluster.this.name
  principal_arn = "arn:aws:iam::219834006508:user/platform-bootstrap"

  type = "STANDARD"
}

resource "aws_eks_access_policy_association" "platform_bootstrap_admin" {

  cluster_name  = aws_eks_cluster.this.name
  principal_arn = aws_eks_access_entry.platform_bootstrap.principal_arn

  policy_arn = "arn:aws:eks::aws:cluster-access-policy/AmazonEKSClusterAdminPolicy"

  access_scope {
    type = "cluster"
  }
}