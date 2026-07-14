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

resource "aws_vpc_security_group_ingress_rule" "cluster_from_nodes" {

  security_group_id = aws_security_group.eks_cluster.id

  referenced_security_group_id = aws_security_group.eks_node.id

  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"

  description = "Allow worker nodes to communicate with EKS API"
}

resource "aws_vpc_security_group_ingress_rule" "node_to_node" {

  security_group_id = aws_security_group.eks_node.id

  referenced_security_group_id = aws_security_group.eks_node.id

  ip_protocol = "-1"

  description = "Node to node communication"
}

resource "aws_vpc_security_group_ingress_rule" "cluster_to_kubelet" {

  security_group_id = aws_security_group.eks_node.id

  referenced_security_group_id = aws_security_group.eks_cluster.id

  from_port = 10250
  to_port   = 10250

  ip_protocol = "tcp"

  description = "Cluster to kubelet communication"
}

resource "aws_vpc_security_group_egress_rule" "node_all_egress" {

  security_group_id = aws_security_group.eks_node.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow all outbound traffic"
}

resource "aws_vpc_security_group_egress_rule" "cluster_all_egress" {

  security_group_id = aws_security_group.eks_cluster.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "Allow outbound traffic"
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 80
  to_port   = 80

  ip_protocol = "tcp"

  description = "HTTP from internet"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  from_port = 443
  to_port   = 443

  ip_protocol = "tcp"

  description = "HTTPS from internet"
}

resource "aws_vpc_security_group_egress_rule" "alb_all_egress" {

  security_group_id = aws_security_group.alb.id

  cidr_ipv4 = "0.0.0.0/0"

  ip_protocol = "-1"

  description = "ALB outbound traffic"
}