provider "aws" {
  region = "eu-west-2"
}

module "vpc" {
  source      = "../modules/vpc"
  vpc_cidr    = "192.168.0.0/16"
  tenancy     = "default"
  vpc_id      = "${module.vpc.vpc_id}"
  subnet_cidr = "192.168.1.0/24"
  sg_id       = "${module.vpc.sg_id}"
}

module "ec2" {
  source        = "../modules/ec2"
  ec2_count     = 1
  ami_id        = "ami-006a0174c6c25ac06"
  instance_type = "t2.micro"
  subnet_id     = "${module.vpc.subnet_id}"
  sg_id         = "${module.vpc.sg_id}"
}
