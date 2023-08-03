data "aws_availability_zones" "azs" {
  state = "available"
}

module "base-network" {
  source  = "cn-terraform/networking/aws"
  version = "2.0.16"

  name_prefix                                 = var.name
  vpc_cidr_block                              = var.vpc_cidr_block
  availability_zones                          = slice(data.aws_availability_zones.azs.names.*, 0, 2)
  public_subnets_cidrs_per_availability_zone  = var.public_subnets_cidrs
  private_subnets_cidrs_per_availability_zone = var.private_subnets_cidrs
}

module "ecs-fargate" {
  source  = "cn-terraform/ecs-fargate/aws"
  version = "2.0.52"

  container_image         = var.container_image
  container_name          = var.container_name
  name_prefix             = var.name
  entrypoint              = var.entrypoint
  command                 = var.command
  private_subnets_ids     = module.base-network.private_subnets_ids
  public_subnets_ids      = module.base-network.public_subnets_ids
  vpc_id                  = module.base-network.vpc_id
  enable_ecs_managed_tags = true
  propagate_tags          = "TASK_DEFINITION"
  lb_http_ports           = var.lb_http_ports
  lb_https_ports          = var.lb_https_ports
  port_mappings           = var.port_mappings
  enable_s3_logs          = false
  tags                    = var.tags
}
