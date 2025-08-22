module "frontend" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = var.frontend_sg_name
  sg_description = var.frontend_sg_description
  vpc_id = local.vpc_id
  }

module "bastian" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = var.bastian_sg_name
  sg_description = var.bastian_sg_description
  vpc_id = local.vpc_id
  }


module "basbackend_alb" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = "backend-alb"
  sg_description = "backend_alb_sg_description"
  vpc_id = local.vpc_id
  }


  resource "aws_security_group_rule" "bastian_laptop_access" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.bastian.sg_id
}

# backend alb accepting connectioins from bastian server
  resource "aws_security_group_rule" "bastian_alb_access_from_bastian" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.bastian.sg_id
  security_group_id = module.basbackend_alb.sg_id
}