
output "identity_provider_arn" {
  value       = aws_iam_saml_provider.saml.arn
  description = "ARN for SAML Identity Provider created in IAM"
}

output "role_arn_admin" {
  description = "ARN for Admin role"
  value       = var.enable_admin_role ? aws_iam_role.admin_role[0].arn : null
}

output "role_arn_power_user" {
  description = "ARN for Power User role"
  value       = var.enable_power_user_role ? aws_iam_role.power_user_role[0].arn : null
}

output "role_arn_read_only" {
  description = "ARN for Read Only role"
  value       = var.enable_read_only_role ? aws_iam_role.read_only_role[0].arn : null
}

output "assume_role_policy" {
  value       = data.aws_iam_policy_document.role_assume.json
  description = "IAM Assume Role Policy to use with other SAML enabled roles."
}

output "max_session_duration_seconds" {
  value       = var.max_session_duration_seconds
  description = "Maximum CLI Session duration in seconds"
}