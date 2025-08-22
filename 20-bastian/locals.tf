locals {
    ami_id = data.aws_ami.joindevops.id
    bastian_sg_id = data.aws_ssm_parameter.bastian_sg_id.value
    public_subnet_id = split(",", data.aws_ssm_parameter.public_subnet_ids.value)[0]

    common_tags = {
        Environment = var.environment
        Project     = var.project
        Terraform = "true"

    } 
}

