resource "aws_instance" "server1" {
  ami = "ami-006a0174c6c25ac06"
  instance_type = "t2.micro"
  key_name = "tf-key"
  subnet_id = "subnet-21199e5b"
  #associate_public_ip_address = "true"
  #private_ip = ""
  
  # Para agregar la instancia a un grupo de seguridad, lo tenemos que poner en una lista
  vpc_security_group_ids = ["sg-05b7511541aa39fec", "sg-32b6a25c"]

  # Si queremos crear más de 1 instancia, ponemos el parámetro count, que por defecto vale 1
  # count = 2

  tags = {
    Name = "server1"
    Owner = "terraform"
    Env = "dev"
  }

}