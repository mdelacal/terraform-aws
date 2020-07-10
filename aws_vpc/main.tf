resource "aws_vpc" "main1" {
  cidr_block = "10.0.0.0/16"
  enable_dns_hostnames = "true"

  tags = {
    name = "Main VPC 1"
  }
}