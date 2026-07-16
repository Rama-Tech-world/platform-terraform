resource "aws_iam_policy" "external_dns" {

  name = "${var.project_name}-${var.environment}-external-dns-policy"

  policy = file("${path.module}/iam-policy.json")
}