variable "region" {
    default = "eu-west-2"
}

variable "ec2_ami" {
    type = "map"
    default = {
        eu-west-2 = "ami-006a0174c6c25ac06"
        eu-east-2 = "ami-xxxxxxxxxxxxxxxxx"
    }
}