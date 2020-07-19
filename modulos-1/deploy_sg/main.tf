provider "aws" {
    region = "eu-west-2"
}

module "security_group" {
    source = "../modules/sg"
    name = "my_security_groups"
    description = "My Security Groups"
    vpc_id = "${module.vpc.vpc_id}"

    ingress_cidr_blocks = ["0.0.0.0/0"]
    ingress_rules = ["ssh-22-tcp", "http-80-tcp", "https-443-tcp", "jboss-8080-tcp"]
    egress_cidr_blocks = ["0.0.0.0/0"]
    egress_rules = ["any"]
    tags = {
        Terraform = "true"
        Environment = "dev"
    }
}

module "vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.vpc.vpc_id}"
  subnet_cidr = "192.168.1.0/24"
  sg_id       = "${module.security_group.id}"
}

module "ec2" {
  source        = "../modules/ec2"
  ec2_count     = 1
  ami_id        = "ami-006a0174c6c25ac06"
  instance_type = "t2.micro"
  subnet_id     = "${module.vpc.subnet_id}"
  sg_id         = "${module.security_group.id}"
}