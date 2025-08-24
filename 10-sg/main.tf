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

module "vpn" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = "vpn"
  sg_description = "for vpn"
  vpc_id = local.vpc_id
  }

module "mongodb" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = "mongodb"
  sg_description = "mongodb access"
  vpc_id = local.vpc_id
  }

module "redis" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = "redis"
  sg_description = "redis access"
  vpc_id = local.vpc_id
  }


module "mysql" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = "mysql"
  sg_description = "mysql access"
  vpc_id = local.vpc_id
  }

module "rabbitmq" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = "rabbitmq"
  sg_description = "rabbitmq access"
  vpc_id = local.vpc_id
  }      


module "catalogue" {
  source = "git::https://github.com/vishnusai34/terraform-aws-securitygroup.git?ref=main"
  project = var.Project
  environment = var.Environment
  sg_name = "Catalogue"
  sg_description = "catalogue access"
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



# backend alb allow connectioins from VPN server
  resource "aws_security_group_rule" "backend_alb_access_from_vpn" {
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.basbackend_alb.sg_id
}

# VPN ports 22, 443, 1194 943

 resource "aws_security_group_rule" "vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
 }

  resource "aws_security_group_rule" "vpn_https" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
 }

  resource "aws_security_group_rule" "vpn_1194" {
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
 }

   resource "aws_security_group_rule" "vpn_943" {
  type              = "ingress"
  from_port         = 943
  to_port           = 943
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = module.vpn.sg_id
 }

  resource "aws_security_group_rule" "mongodb_vpn_ssh" {
  count = length(var.mongodb_ports_vpn)
  type              = "ingress"
  from_port         = var.mongodb_ports_vpn[count.index]
  to_port           = var.mongodb_ports_vpn[count.index]
  protocol          = "tcp"
  security_group_id = module.mongodb.sg_id
  source_security_group_id = module.vpn.sg_id

 }

  resource "aws_security_group_rule" "redis_vpn_ssh" {
  count = length(var.redis_ports_vpn)
  type              = "ingress"
  from_port         = var.redis_ports_vpn[count.index]
  to_port           = var.redis_ports_vpn[count.index]
  protocol          = "tcp"
  security_group_id = module.redis.sg_id
  source_security_group_id = module.vpn.sg_id

 }

   resource "aws_security_group_rule" "mysql_vpn_ssh" {
  count = length(var.mysql_ports_vpn)
  type              = "ingress"
  from_port         = var.mysql_ports_vpn[count.index]
  to_port           = var.mysql_ports_vpn[count.index]
  protocol          = "tcp"
  security_group_id = module.mysql.sg_id
  source_security_group_id = module.vpn.sg_id

 }

   resource "aws_security_group_rule" "rabbitmq_vpn_ssh" {
  count = length(var.rabbitmq_ports_vpn)
  type              = "ingress"
  from_port         = var.rabbitmq_ports_vpn[count.index]
  to_port           = var.rabbitmq_ports_vpn[count.index]
  protocol          = "tcp"
  security_group_id = module.rabbitmq.sg_id
  source_security_group_id = module.vpn.sg_id

 }
# catalgue security group rules for the backend alb to access catalogue service
   resource "aws_security_group_rule" "catalogue_backend_alb" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.basbackend_alb.sg_id
  security_group_id = module.catalogue.sg_id
}


# catalgue security group rules for vpn ssh access to catalogue service
   resource "aws_security_group_rule" "catalogue_vpn_ssh" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}

# catalgue security group rules for vpn http access to catalogue service
   resource "aws_security_group_rule" "catalogue_vpn_http" {
  type              = "ingress"
  from_port         = 8080
  to_port           = 8080
  protocol          = "tcp"
  source_security_group_id = module.vpn.sg_id
  security_group_id = module.catalogue.sg_id
}


# catalgue security group rules for connectiong from bastian server to catalogue service
   resource "aws_security_group_rule" "catalogue_bastian" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  source_security_group_id = module.bastian.sg_id
  security_group_id = module.catalogue.sg_id
}


# catalgue security group rules for mongodb for connectiong from catalgue service 
   resource "aws_security_group_rule" "mongodb_catalogue" {
  type              = "ingress"
  from_port         = 27017
  to_port           = 27017
  protocol          = "tcp"
  source_security_group_id = module.catalogue.sg_id
  security_group_id = module.mongodb.sg_id
}

