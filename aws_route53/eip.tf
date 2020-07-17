# resource "aws_eip" "default" {
#     instance = "${aws_instance.server1.id}"
#     vpc = true

#     tags = {
#         Name = "server1 eip"
#     }
# }

resource "aws_eip" "one" {
    vpc = true
}

resource "aws_eip" "two" {
    vpc = true
}

resource "aws_eip_association" "eip_server1" {
    instance_id = "${aws_instance.server1.id}"
    allocation_id = "${aws_eip.one.id}"
}

resource "aws_eip_association" "eip_server2" {
    instance_id = "${aws_instance.server2.id}"
    allocation_id = "${aws_eip.two.id}"
}