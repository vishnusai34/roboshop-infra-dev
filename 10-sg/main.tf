module "frontend" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = var.frontend_sg_name
  sg_description = var.frontend_sg_description


    vpc_id = local.vpc_id
  }

