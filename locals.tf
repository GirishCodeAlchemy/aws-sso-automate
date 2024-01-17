locals {
  test_build           = var.build_number != ""
  resource_name_prefix = local.test_build ? "tb-${var.build_number}-1x0" : module.config.environment_config_map.resource_name_prefix
  region               = module.config.environment_config_map.region
  account_id           = module.config.environment_config_map.account_id
  vpc_id               = module.config.environment_config_map.vpc_id
  default_provider_tags = {
    "environment"    = module.config.environment_config_map.environment
    "owner"          = module.config.environment_config_map.owner
    "program"        = module.config.environment_config_map.program
    "provisioned-by" = module.config.environment_config_map.owner
  }
}
