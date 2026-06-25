//Launch template

resource "aws_launch_template" "this" {
  name_prefix   = "${var.environment}-lt"
  image_id      = var.ami_id
  instance_type = var.instance_type

  vpc_security_group_ids = [
    var.ec2_sg_id
  ]

  user_data = base64encode(<<EOF
#!/bin/bash

apt update -y
apt install -y nginx

systemctl enable nginx
systemctl start nginx

echo "<h1>${var.environment} Environment</h1>" > /usr/share/nginx/html/index.html
EOF
  )
}

//ASG

resource "aws_autoscaling_group" "this" {

  name = "${var.environment}-asg"

  desired_capacity = var.desired_capacity
  min_size         = var.min_size
  max_size         = var.max_size

  vpc_zone_identifier = var.private_subnet_ids

  target_group_arns = [
    var.target_group_arn
  ]

  launch_template {
    id      = aws_launch_template.this.id
    version = "$Latest"
  }

  health_check_type = "ELB"

  tag {
    key                 = "Name"
    value               = "${var.environment}-ec2"
    propagate_at_launch = true
  }
}
