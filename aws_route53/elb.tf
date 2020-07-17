resource "aws_elb" "my_elb" {
    name = "my-elb"
    # availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]
    subnets = ["${aws_subnet.subnet1.id}", "${aws_subnet.subnet2.id}", "${aws_subnet.subnet3.id}"]

    security_groups = ["${aws_security_group.elb_http.id}"]

    listener {
        instance_port = 80
        instance_protocol = "http"
        lb_port = 80
        lb_protocol = "http"
    }

    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        target = "HTTP:80/"
        interval = 10
    }

    instances = ["${aws_instance.server1.id}", "${aws_instance.server2.id}"]
    cross_zone_load_balancing = true
    idle_timeout = 400
    connection_draining = true
    connection_draining_timeout = 400

    tags = {
        Name = "my_elb"
    }
}