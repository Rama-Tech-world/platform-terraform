resource "aws_iam_policy" "alb_controller" {

  name = "${var.project_name}-${var.environment}-alb-controller-policy"

  policy = file("${path.module}/iam-policy.json")
}