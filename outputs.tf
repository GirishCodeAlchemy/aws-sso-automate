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




output "aws_identitystore_user" {
  description = "The AWS Identity Store User details"
  value       = module.sso.aws_identitystore_user
}

output "aws_identitystore_group" {
  description = "The AWS Identity Store Group details"
  value       = module.sso.aws_identitystore_group
}

output "aws_identitystore_group_membership" {
  description = "The AWS Identity Store Group Membership details"
  value       = module.sso.aws_identitystore_group_membership
}

output "aws_ssoadmin_permission_set" {
  description = "The AWS SSO Admin Permission Set details"
  value       = module.sso.aws_ssoadmin_permission_set
}

output "aws_ssoadmin_permission_set_inline_policy" {
  description = "The AWS SSO Admin Permission Set Inline Policy details"
  value       = module.sso.aws_ssoadmin_permission_set_inline_policy
}

output "aws_ssoadmin_managed_policy_attachment" {
  description = "The AWS SSO Admin Managed Policy Attachment details"
  value       = module.sso.aws_ssoadmin_managed_policy_attachment
}

output "aws_ssoadmin_account_assignment_user" {
  description = "The AWS SSO Admin Account Assignment User details"
  value       = module.sso.aws_ssoadmin_account_assignment_user
}

output "aws_ssoadmin_account_assignment_group" {
  description = "The AWS SSO Admin Account Assignment Group details"
  value       = module.sso.aws_ssoadmin_account_assignment_group
}
