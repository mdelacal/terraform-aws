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
