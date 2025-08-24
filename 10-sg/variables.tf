variable "Project" {
    default = "roboshop"
  
}

variable "Environment" {
    default = "dev"
  
}

variable "frontend_sg_name" {
    default = "frontend"
  
}

variable "frontend_sg_description" {
    default = "created sg for frontend services"
  
}

variable "bastian_sg_name" {
    default = "bastian"
  
}

variable "bastian_sg_description" {
    default = "created sg for bastian server"
  
}

variable "mongodb_ports_vpn" {
    default = ["22","27017"]
  
}

variable "redis_ports_vpn" {
    default = ["22","6379"]
  
}

variable "mysql_ports_vpn" {
    default = ["22","3306"]
  
}

variable "rabbitmq_ports_vpn" {
    default = ["22","5672"]
  
}
