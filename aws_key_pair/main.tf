resource "aws_key_pair" "key-class1" {
  key_name = "class_key1"
  public_key = "ssh-rsa ..."
}

resource "aws_key_pair" "tf-key" {
  key_name = "tf-key"
  public_key = "${file("/home/miguel/.aws/tf-key.pem")}"
}