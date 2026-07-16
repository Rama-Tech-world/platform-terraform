resource "aws_iam_instance_profile" "karpenter_node" {

  name = "${var.project_name}-${var.environment}-karpenter-node-profile"

  role = aws_iam_role.karpenter_node.name
}