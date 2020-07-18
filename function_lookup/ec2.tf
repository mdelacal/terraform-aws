resource "aws_instance" "web1" {
    #ami = "${var.ec2_ami}"
    ami = "${lookup(var.ec2_ami, var.region)}"
    instance_type = "t2.micro"
    key_name = "tf-key"

    tags = {
        Name = "web1"
    }
}