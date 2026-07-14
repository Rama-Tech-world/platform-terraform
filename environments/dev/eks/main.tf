module "eks" {

  source = "../../../modules/eks"

  project_name = var.project_name
  environment  = var.environment

  cluster_version = var.cluster_version

  vpc_id = data.terraform_remote_state.networking.outputs.vpc_id

  private_subnet_ids = data.terraform_remote_state.networking.outputs.private_app_subnet_ids

  cluster_role_arn = data.terraform_remote_state.iam.outputs.eks_cluster_role_arn

  node_role_arn = data.terraform_remote_state.iam.outputs.eks_node_role_arn

  cluster_security_group_id = data.terraform_remote_state.security.outputs.eks_cluster_sg_id

  node_security_group_id = data.terraform_remote_state.security.outputs.eks_node_sg_id

  kms_key_arn = data.terraform_remote_state.kms.outputs.kms_key_arn
  
}