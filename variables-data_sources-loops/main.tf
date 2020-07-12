provider "aws" {
    region = "${var.region}"
}

resource "aws_vpc" "main1" {
    cidr_block = "${var.vpc_cidr}"
    instance_tenancy = "default"
    enable_dns_hostnames = "true"

    tags = {
        Name = "Main1"
        Location = "EU"
    }
}

resource "aws_subnet" "subnet1" {
    vpc_id = "${aws_vpc.main1.id}"
    cidr_block = "${var.subnet_cidr}"

    tags = {
        Name = "Subnet1"
    }
}