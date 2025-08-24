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

resource "aws_ssm_parameter" "vpn_sg_id" {
  name  = "/${var.Project}/${var.Environment}/vpn_sg_id"
  type  = "String"
  value = module.vpn.sg_id
}

resource "aws_ssm_parameter" "mongodb_sg_id" {
  name  = "/${var.Project}/${var.Environment}/mongodb_sg_id"
  type  = "String"
  value = module.mongodb.sg_id
}

resource "aws_ssm_parameter" "redis_sg_id" {
  name  = "/${var.Project}/${var.Environment}/redis_sg_id"
  type  = "String"
  value = module.redis.sg_id
}

resource "aws_ssm_parameter" "mysql_sg_id" {
  name  = "/${var.Project}/${var.Environment}/mysql_sg_id"
  type  = "String"
  value = module.mysql.sg_id
}

resource "aws_ssm_parameter" "rabbitmq_sg_id" {
  name  = "/${var.Project}/${var.Environment}/rabbitmq_sg_id"
  type  = "String"
  value = module.mongodb.sg_id
}

resource "aws_ssm_parameter" "catalogue_sg_id" {
  name  = "/${var.Project}/${var.Environment}/catalogue_sg_id"
  type  = "String"
  value = module.catalogue.sg_id
}