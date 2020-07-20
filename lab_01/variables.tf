variable "region" {
  default = "eu-west-2"
}

variable "amis" {
    default = {
        eu-west-2 = "ami-006a0174c6c25ac06" # ubuntu
    }
}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.30.0/24"
}

variable "private_subnet_cidr" {
  default = "10.0.40.0/24"
}

variable "aws_key_name" {
    default = "tf-key"
}
