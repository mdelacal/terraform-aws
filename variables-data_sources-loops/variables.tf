variable "region" {
    default = "eu-west-2"
}

variable "vpc_cidr" {
    default = "192.168.0.0/16"
}

variable "subnet_cidr" {
    type = "list"
    default = ["192.168.1.0/24", "192.168.2.0/24", "192.168.3.0/24"]
}

# Availability zones
variable "azs_list" {
    type = "list"
    default = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
}

# Declare the data source
data "aws_availability_zones" "azs" {
  state = "available"
}