resource "aws_key_pair" "sample_key_name" {
    key_name = "sample_key"
    public_key = "${file("class_key.pem.pub")}"
}