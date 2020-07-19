provider "aws" {
    region = "eu-west-2"
}

resource "aws_launch_configuration" "web" {
    name_prefix = "web-1"

    image_id = "ami-<id_image>"
    instance_type = "t2.micro"
    security_groups = ["sg-<id_sg>"]
    associate_public_ip_address = "false"

    lifecycle {
        create_before_destroy = true
    }
}

resource "aws_security_group" "elb_http" {
    name = "elb_http"
    description = "Allow HTTP traffic to instances through Elastic Load Balancer"
    vpc_id = "vpc-<id_vpc>"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }

    tags = {
        Name = "Allow HTTP through ELB Security Group"
    }
}

resource "aws_elb" "web_elb" {
    name = "web-elb"
    security_groups = ["${aws_security_group.elb_http.id}"]
    subnets = ["subnet-<id_subnet_1>", "subnet-<id_subnet_2", "..."]
    cross_zone_load_balancing = true
    health_check {
        healthy_threshold = 2
        unhealthy_threshold = 2
        timeout = 3
        interval = 30
        target = "HTTP:80/index.php"
    }
    listener {
        lb_port = 80
        lb_protocol = "http"
        instance_port = "80"
        instance_protocol = "http"
    }
}

resource "aws_elb_attachment" "baz" {
    elb = "${aws_elb.web_elb.id}"
    instance = "i-<instance_id>"
}

resource "aws_autoscaling_group" "web" {
    name = "${aws_launch_configuration.web.name}-asg"

    min_size = 2
    desired_capacity = 2
    max_size = 10

    health_check_type = "ELB"
    load_balancers = ["${aws_launch_configuration.web.name}"]
    availability_zones = ["eu-west-2a", "eu-west-2b", "eu-west-2c"]

    enabled_metrics = [
        "GroupMinSize",
        "GroupMaxSize",
        "GroupDesiredCapacity",
        "GroupInServiceInstances",
        "GroupTotalInstances"
    ]

    metrics_granularity = "1Minute"

    vpc_zone_identifier = ["subnet-<id_subnet>"]

    # Required to redeploy without an outage
    lifecycle {
        create_before_destroy = true
    }

    tag {
        key = "Name"
        value = "web"
        propagate_at_launch = true
    }
}

resource "aws_autoscaling_policy" "web_policy_up" {
    name = "web_policy_up"
    scaling_adjustment = 1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.web.name}"
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_up" {
    alarm_name = "web_cpu_alarm_up"
    comparison_operator = "GreaterThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "30"

    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.web.name}"
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    alarm_actions = ["${aws_autoscaling_policy.web_policy_up.arn}"]
}

resource "aws_autoscaling_policy" "web_policy_down" {
    name = "web_policy_down"
    scaling_adjustment = -1
    adjustment_type = "ChangeInCapacity"
    cooldown = 300
    autoscaling_group_name = "${aws_autoscaling_group.web.name}"
}

resource "aws_cloudwatch_metric_alarm" "web_cpu_alarm_down" {
    alarm_name = "web_cpu_alarm_down"
    comparison_operator = "LessThanOrEqualToThreshold"
    evaluation_periods = "2"
    metric_name = "CPUUtilization"
    namespace = "AWS/EC2"
    period = "60"
    statistic = "Average"
    threshold = "5"

    dimensions = {
        AutoScalingGroupName = "${aws_autoscaling_group.web.name}"
    }

    alarm_description = "This metric monitor EC2 instance CPU utilization"
    alarm_actions = ["${aws_autoscaling_policy.web_policy_down.arn}"]
}

output "ELB_IP" {
    value = "${aws_elb.web_elb.dns_name}"
}