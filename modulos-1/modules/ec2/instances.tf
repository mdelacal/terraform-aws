resource "aws_instance" "web1" {
  count                       = "${var.ec2_count}"
  ami                         = "${var.ami_id}"
  instance_type               = "${var.instance_type}"
  subnet_id                   = "${var.subnet_id}"
  vpc_security_group_ids      = ["${var.sg_id}"]
  associate_public_ip_address = "true"

  tags = {
    Name = "Hello-Instance"
  }
}
