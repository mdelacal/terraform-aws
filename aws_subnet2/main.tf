resource "aws_vpc" "main1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    name = "Main VPC 1"
  }
}

resource "aws_subnet" "subnet1" {
  vpc_id = "${aws_vpc.main1.id}"
  cidr_block = "10.0.10.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-west-2a"
  
  tags = {
    Name = "Subnet 1 en eu-west-2a"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id = "${aws_vpc.main1.id}"
  cidr_block = "10.0.20.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-west-2b"
  
  tags = {
    Name = "Subnet 2 en eu-west-2b"
  }
}

resource "aws_subnet" "subnet3" {
  vpc_id = "${aws_vpc.main1.id}"
  cidr_block = "10.0.30.0/24"
  map_public_ip_on_launch = "true"
  availability_zone = "eu-west-2c"
  
  tags = {
    Name = "Subnet 3 en eu-west-2c"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main1.id}"

  tags = {
    Name = "Gateway Main"
  }
}

resource "aws_route_table" "r" {
  vpc_id = "${aws_vpc.main1.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
}

resource "aws_route_table_association" "table_subnet1" {
  subnet_id = "${aws_subnet.subnet1.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_route_table_association" "table_subnet2" {
  subnet_id = "${aws_subnet.subnet2.id}"
  route_table_id = "${aws_route_table.r.id}"
}

resource "aws_route_table_association" "table_subnet3" {
  subnet_id = "${aws_subnet.subnet3.id}"
  route_table_id = "${aws_route_table.r.id}"
}