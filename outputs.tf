output "aws_user_permissionset" {
  description = "The AWS SSO Permission Set for users"
  value       = { for k, v in module.sso.data.aws_ssoadmin_permission_set.aws_user_permissionset : k => v }
}

output "aws_group_permissionset" {
  description = "The AWS SSO Permission Set for groups"
  value       = { for k, v in module.sso.data.aws_ssoadmin_permission_set.aws_group_permissionset : k => v }
}

output "aws_group_ids" {
  description = "The IDs of the AWS Identity Store Groups"
  value       = { for k, v in module.sso.data.aws_identitystore_group.aws_group : k => v.group_id }
}
