resource "aws_ssm_parameter" "frontend_sg_id" {
  name  = "/${var.Project}/${var.Environment}/frontend_sg_id"
  type  = "String"
  value = module.frontend.sg_id
}

resource "aws_ssm_parameter" "bastian_sg_id" {
  name  = "/${var.Project}/${var.Environment}/bastian_sg_id"
  type  = "String"
  value = module.bastian.sg_id
}

resource "aws_ssm_parameter" "backend_alb_sg_id" {
  name  = "/${var.Project}/${var.Environment}/backend_alb_sg_id"
  type  = "String"
  value = module.basbackend_alb.sg_id
}