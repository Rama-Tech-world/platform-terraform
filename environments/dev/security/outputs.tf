output "eks_cluster_sg_id" {
  value = module.security_group.eks_cluster_sg_id
}

output "eks_node_sg_id" {
  value = module.security_group.eks_node_sg_id
}

output "alb_sg_id" {
  value = module.security_group.alb_sg_id
}