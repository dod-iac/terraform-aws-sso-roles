
output "identity_provider_arn" {
  value = format("arn:%s:iam::*:saml-provider/%s",
    data.aws_partition.current.partition,
    var.saml_provider_name,
  )
  description = "ARN for SAML Identity Provider created in IAM"
}

output "role_arn_admin" {
  description = "ARN for Admin role"
  value       = aws_iam_role.admin_role[0].arn
}

output "role_arn_power_user" {
  description = "ARN for Power User role"
  value       = aws_iam_role.power_user_role[0].arn
}

output "role_arn_read_only" {
  description = "ARN for Read Only role"
  value       = aws_iam_role.read_only_role[0].arn
}
