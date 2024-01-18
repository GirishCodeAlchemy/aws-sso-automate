module "config" {
  source = "git@github.com:GirishCodeAlchemy/alchemy-terraform-config.git"
}
data "aws_ssoadmin_instances" "ssoadmin" {}

############################## Users,Group,Group's Membership #########################################
# Create SSO users
resource "aws_identitystore_user" "aws_user" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmin.identity_store_ids)[0]

  display_name = "Girish V"
  user_name    = "girish"

  name {
    given_name  = "girish"
    family_name = "v"
  }

  emails {
    primary = true
    value   = "vgirish.ca@gmail.com" # Replace with your email ID
  }
}

########################### Groups #################################################
# Create Group
resource "aws_identitystore_group" "aws_group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmin.identity_store_ids)[0]
  display_name      = "L1-devops-group"
  description       = "This is AWS L1 Devops Group"
}


####################### Group Membership ############################################
# Create Group Membership for the user
resource "aws_identitystore_group_membership" "aws_group_membership" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmin.identity_store_ids)[0]
  group_id          = aws_identitystore_group.aws_group.group_id
  member_id         = aws_identitystore_user.aws_user.user_id
}

##################### Permission Sets #######################################

# Create Custom Permission Set
resource "aws_ssoadmin_permission_set" "permissionset" {

  name         = "SSM-testing-permissionset"
  instance_arn = tolist(data.aws_ssoadmin_instances.ssoadmin.arns)[0]
}


data "aws_iam_policy_document" "policy" {
  statement {
    sid = "1"

    actions = [
      "s3:ListAllMyBuckets",
      "s3:GetBucketLocation",
      "s3:ListBucket"
    ]

    resources = [
      "arn:aws:s3:::*",
    ]
  }
}

# Custom permission set Inline policy
resource "aws_ssoadmin_permission_set_inline_policy" "inline_policy" {
  inline_policy      = data.aws_iam_policy_document.policy.json
  instance_arn       = tolist(data.aws_ssoadmin_instances.ssoadmin.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.permissionset.arn
}


########################## AWS Account/ Assignment ###################################

# Create Account Assignment to the group with Custom permission sets
resource "aws_ssoadmin_account_assignment" "sso_account" {
  instance_arn       = tolist(data.aws_ssoadmin_instances.ssoadmin.arns)[0]
  permission_set_arn = aws_ssoadmin_permission_set.permissionset.arn

  # principal_id   = aws_identitystore_group.aws_group.id
  principal_id   = element(split("/", aws_identitystore_group.aws_group.id), length(split("/", aws_identitystore_group.aws_group.id)) - 1) # Corrected
  principal_type = "GROUP"

  target_id   = local.account_id
  target_type = "AWS_ACCOUNT"
}
