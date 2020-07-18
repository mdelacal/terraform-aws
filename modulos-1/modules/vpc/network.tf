resource "aws_vpc" "main" {
  cidr_block           = "${var.vpc_cidr}"
  instance_tenancy     = "${var.tenancy}"
  enable_dns_hostnames = "${var.vpc_hostnames}"
  tags = {
    Name = "VPC con SG"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = "${var.vpc_id}"
  cidr_block = "${var.subnet_cidr}"
  tags = {
    Name = "Subnet-1"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = "${aws_vpc.main.id}"
  tags = {
    Name = "VPC IGW"
  }
}

resource "aws_route_table" "rt" {
  vpc_id = "${aws_vpc.main.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.gw.id}"
  }
  tags = {
    Name = "Public Subnet RT"
  }
}

resource "aws_route_table_association" "public-rt" {
  subnet_id      = "${aws_subnet.subnet.id}"
  route_table_id = "${aws_route_table.rt.id}"
}

resource "aws_security_group" "server" {
  name        = "vpc_sg"
  description = "Allow incoming connections."

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  vpc_id = "${aws_vpc.main.id}"

  tags = {
    Name = "ServerSG"
  }
}
