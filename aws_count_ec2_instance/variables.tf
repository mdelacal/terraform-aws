variable "region" {
    description = "Región a utilizar en AWS"
    #default = "eu-west-2"
}

variable "ami_id" {
    description = "AMI id para ubuntu18 eu-west-2"
    #default = "ami-006a0174c6c25ac06"
}

# Variable para el ejemplo de aws_vpc
variable "vpc_cidr" {
    description = "VPC cidr"
    #default = "10.0.0.0/16"
}

# Variables para el ejemplo de aws_subnet
variable "subnet1_cidr" {
    description = "Subnet 1 cidr"
    #default = "10.0.10.0/24"
}

variable "subnet2_cidr" {
    description = "Subnet 2 cidr"
    #default = "10.0.20.0/24"
}

variable "subnet3_cidr" {
    description = "Subnet 3 cidr"
    #default = "10.0.30.0/24"
}

variable "subnet1_zone_2a" {
    description = "Zone 2a - Subnet 1"
    #default = "eu-west-2a"
}

variable "subnet2_zone_2b" {
    description = "Zone 2b - Subnet 2"
    #default = "eu-west-2b"
}

variable "subnet3_zone_2c" {
    description = "Zone 2c - Subnet 3"
    #default = "eu-west-2c"
}

variable "subnet1_private_ip" {
    description = "IP privada de la instancia"
}