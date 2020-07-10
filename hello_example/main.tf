# Crear recurso "aws_instance" con nombre ec2_terraform
resource "aws_instance" "ec2_terraform" {
  ami = "ami-006a0174c6c25ac06"
  instance_type = "t2.micro"
  key_name = "tf-key"
  subnet_id = "subnet-21199e5b"
  # Para el grupo de seguridad ponemos el ID, no el nombre
  vpc_security_group_ids = ["sg-05b7511541aa39fec"] 
}