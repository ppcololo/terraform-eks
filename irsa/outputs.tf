output "pod_role_arn" {
  value = aws_iam_role.pod_s3_access.arn
}

output "service_account_name" {
  value = var.service_account_name
}