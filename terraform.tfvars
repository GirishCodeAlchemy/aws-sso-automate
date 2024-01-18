sso_user_configmap = {
  girish1 = {
    display_name = "Girish V"
    user_name    = "girish1"
    given_name   = "Girish"
    family_name  = "V"
    email        = "girish1@example.com"
  },
  girish2 = {
    display_name = "Girish V"
    user_name    = "girish2"
    given_name   = "Girish"
    family_name  = "V"
    email        = "girish2@example.com"
  }
}

sso_groups_configmap = {
  "L1-devops-group" = {
    display_name = "L1-devops-group"
    description  = "This is AWS L1 Devops Group"
    users        = ["girish1", "girish2"]
  },
  "L1-Admin-group" = {
    display_name = "L1-Admin-group"
    description  = "This is AWS L1 Admin Group"
    users        = ["girish1"]
  }
}

sso_permissionsets_configmap = {
  "SSM-Admin-permissionset" = {
    description         = "Sample Admin permissionset"
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess"]
    inline_policy       = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Action": [
                "ecr:*",
                "secretsmanager:*",
                "s3:*",
                "lambda:*",
                "states:*"
            ],
            "Resource": "*"
            }
        ]
    }
    EOF
  },
  "SSM-testing-permissionset" = {
    description         = "Sample testing permissionset"
    managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonEC2FullAccess"]
    inline_policy       = <<-EOF
    {
        "Version": "2012-10-17",
        "Statement": [
            {
            "Effect": "Allow",
            "Action": [
                "s3:ListAllMyBuckets",
                "s3:GetBucketLocation"
            ],
            "Resource": "arn:aws:s3:::*"
            }
        ]
    }
    EOF
  }
}

sso_account_configmap = {
  "317710176731" = {
    users = {
      girishcodealchemy = { username = "girishcodealchemy", permissionset = ["SSM-testing-permissionset"] }
    }
    groups = {
      L1devopsgroup = { groupname = "L1-devops-group", permissionset = ["SSM-testing-permissionset", "SSM-Admin-permissionset"] }
    }
  },
  "767397783292" = {
    users = {
      girishcodealchemy = { username = "girishcodealchemy", permissionset = ["SSM-testing-permissionset"] }
    }
    groups = {
      L1devopsgroup = { groupname = "L1-devops-group", permissionset = ["SSM-testing-permissionset"] },
      L1AdminGroup  = { groupname = "L1-Admin-group", permissionset = ["SSM-Admin-permissionset"] }
    }
  }
}
