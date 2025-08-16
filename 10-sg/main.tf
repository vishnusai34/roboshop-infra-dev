module "frontend" {
  source = "../../terraform-aws-securitygroup"
  project = var.Project
  environment = var.Environment
  sg_name = var.frontend_sg_name
  sg_description = var.frontend_sg_description


    vpc_id = local.vpc_id
  }

