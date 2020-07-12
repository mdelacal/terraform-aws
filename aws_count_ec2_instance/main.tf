resource "aws_instance" "server1" {
  #ami = "ami-006a0174c6c25ac06"
  ami = "${var.ami_id}"
  instance_type = "t2.micro"
  key_name = "tf-key"
  subnet_id = "subnet-21199e5b"
  #associate_public_ip_address = "true"
  #private_ip = ""
  
  # Si queremos crear más de 1 instancia, ponemos el parámetro count, que por defecto vale 1
  #count = 2
  count = "${length(var.subnets_private_ip)}"
  private_ip = "${element(var.subnets_private_ip, count.index)}"

  tags = {
    Name = "server-${count.index + 1}"
    Owner = "terraform"
    Env = "dev"
  }

}