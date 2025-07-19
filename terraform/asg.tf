data "aws_ssm_parameter" "ecs_node_ami" {
  name = "/aws/service/ecs/optimized-ami/amazon-linux-2023/recommended/image_id"
}

resource "aws_launch_template" "launch_template" {
  name_prefix   = var.template_prefix
  image_id      = data.aws_ssm_parameter.ecs_node_ami.value
  instance_type = var.instance_type

  vpc_security_group_ids = [aws_security_group.ecs_node_sg.id]

  iam_instance_profile {
    arn = aws_iam_instance_profile.ecs_node.arn
  }

  user_data = base64encode(<<-EOF
    #!/bin/bash
    echo ECS_CLUSTER=${var.ecs_cluster} >> /etc/ecs/ecs.config
  EOF
  )
}

resource "aws_autoscaling_group" "asg" {
  name                = var.asg
  min_size            = var.min_capacity
  max_size            = var.max_capacity
  desired_capacity    = var.desired_capacity
  vpc_zone_identifier = aws_subnet.private.*.id
  force_delete        = true

  launch_template {
    id      = aws_launch_template.launch_template.id
    version = "$Latest"
  }

  tag {
    key                 = "AmazonECSManaged"
    value               = true
    propagate_at_launch = true
  }
}

