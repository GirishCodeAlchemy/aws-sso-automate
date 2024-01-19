output "aws_user_permissionset" {
  description = "The AWS SSO Permission Set for users"
  value       = module.sso.aws_user_permissionset
}

output "aws_group_permissionset" {
  description = "The AWS SSO Permission Set for groups"
  value       = module.sso.aws_group_permissionset
}

output "aws_group_ids" {
  description = "The IDs of the AWS Identity Store Groups"
  value       = module.sso.aws_group_ids
}
