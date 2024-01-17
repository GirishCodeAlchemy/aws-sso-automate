module "config" {
  source = "git@github.com:GirishCodeAlchemy/alchemy-terraform-config.git"
}
data "aws_ssoadmin_instances" "ssoadmin" {}

############################## Users,Group,Group's Membership #########################################
# Create SSO users
resource "aws_identitystore_user" "aws_user" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmin.identity_store_ids)[0]

  display_name = "Girish V"
  user_name    = "girishcodealchemy"

  name {
    given_name  = "girish"
    family_name = "v"
  }

  emails {
    value = "girishcodealchemy@gmail.com" # Replace with your email ID
  }
}

########################### Groups #################################################
# Create Group
resource "aws_identitystore_group" "aws_group" {
  identity_store_id = tolist(data.aws_ssoadmin_instances.ssoadmin.identity_store_ids)[0]
  display_name      = "L1-ops-group"
  description       = "This is my AWS ops Group"
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



# module "lambda" {
#   source = "git@github.com:GirishCodeAlchemy/terraform-lambda-module.git"

#   for_each = module.config.lambda_configmap

#   resource_name_prefix       = local.resource_name_prefix
#   image_uri                  = try(each.value.image_uri, null)
#   package_type               = try(each.value.package_type, "Image")
#   vpc_id                     = each.value.vpc_id
#   environment_variables      = try(each.value.environment_variables, null)
#   lambda_name                = each.key
#   lambda_handler             = each.value.lambda_handler
#   lambda_description         = each.value.lambda_description
#   managed_policy_arns        = each.value.managed_policy_arns
#   lambda_has_inline_policy   = try(each.value.lambda_has_inline_policy, false)
#   lambda_inline_policy       = try(each.value.lambda_inline_policy, null)
#   schedule_time_trigger      = try(each.value.schedule_time_trigger, null)
#   aws_lambda_permission      = try(each.value.aws_lambda_permission, [])
#   lambda_assume_role_policy  = try(each.value.lambda_assume_role_policy, null)
#   timeout                    = try(each.value.timeout, 3)
#   memory_size                = try(each.value.memory_size, 128)
#   source_path                = try(each.value.source_path, null)
#   runtime                    = try(each.value.runtime, "python3.10")
#   auto_update_function_image = try(each.value.auto_update_function_image, false)
#   tags                       = try(each.value.tags, {})
#   architectures              = try(each.value.architectures, ["x86_64"])
#   sg_rules                   = try(each.value.sg_rules, [])
# }




# module "sso" {
#   source              = "./modules/sso"
#   sso_instance_name   = "my-sso-instance"
#   permission_set_name = "my-permission-set"
#   sso_instance_arn    = module.sso.sso_instance_arn
#   app_instance_id     = module.sso.app_instance_id
# }

