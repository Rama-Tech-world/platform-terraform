resource "aws_security_group" "eks_cluster" {

  name        = "${local.name_prefix}-eks-cluster-sg"
  description = "EKS Control Plane Security Group"

  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-cluster-sg"
    }
  )
}

resource "aws_security_group" "eks_node" {

  name        = "${local.name_prefix}-eks-node-sg"
  description = "EKS Node Security Group"

  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-eks-node-sg"
    }
  )
}

resource "aws_security_group" "alb" {

  name        = "${local.name_prefix}-alb-sg"
  description = "ALB Security Group"

  vpc_id = var.vpc_id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-alb-sg"
    }
  )
}

output "eks_cluster_sg_id" {
  value = aws_security_group.eks_cluster.id
}

output "eks_node_sg_id" {
  value = aws_security_group.eks_node.id
}

output "alb_sg_id" {
  value = aws_security_group.alb.id
}