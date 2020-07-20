resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags = {
        Name = "terraform-aws-vpc"
    }
}

resource "aws_internet_gateway" "production-igw" {
    vpc_id = "${aws_vpc.default.id}"
    tags = {
        Name = "Production-IGW"
    }
}

# Public Subnet
resource "aws_subnet" "eu-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "eu-west-2a"
    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "eu-west-2a-public" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.production-igw.id}" 
    }
}

resource "aws_route_table_association" "eu-west-2a-public" {
    subnet_id = "${aws_subnet.eu-west-2a-public.id}"
    route_table_id = "${aws_route_table.eu-west-2a-public.id}"
}

# Private Subnet
resource "aws_subnet" "eu-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"
    cidr_block = "${var.private_subnet_cidr}"
    availability_zone = "eu-west-2a"
    tags = {
        Name = "Public Subnet"
    }
}

resource "aws_route_table" "eu-west-2a-private" {
    vpc_id = "${aws_vpc.default.id}"
    route {
        cidr_block = "0.0.0.0/0"
        instance_id = "${aws_instance.nat.id}"
    }
}

resource "aws_route_table_association" "eu-west-2a-private" {
    subnet_id = "${aws_subnet.eu-west-2a-private.id}"
    route_table_id = "${aws_route_table.eu-west-2a-private.id}"
}