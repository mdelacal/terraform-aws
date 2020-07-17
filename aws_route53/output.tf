output "elb_dns_name" {
    value = "${aws_elb.my_elb.dns_name}"
}

output "server1_ip" {
    value = "${aws_instance.server1.private_ip}"
}

output "server2_ip" {
    value = "${aws_instance.server2.private_ip}"
}

output "server1_eip" {
    value = "${aws_instance.one.public_ip}"
}

output "server2_eip" {
    value = "${aws_instance.two.public_ip}"
}