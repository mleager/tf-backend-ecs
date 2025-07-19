# ---- ALB Security Group ----

resource "aws_security_group" "alb_sg" {
  name        = "${var.alb}-sg"
  description = "Security Group for ALB"
  vpc_id      = local.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "alb_http" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  to_port           = 80
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_ingress_rule" "alb_https" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  to_port           = 443
  ip_protocol       = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "alb_egress" {
  security_group_id = aws_security_group.alb_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ---- ECS Node Security Group ----

resource "aws_security_group" "ecs_node_sg" {
  name        = "${var.ecs_cluster}-node-sg"
  description = "Security Group for ECS EC2 instances"
  vpc_id      = local.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ecs_from_alb" {
  security_group_id            = aws_security_group.ecs_node_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  ip_protocol                  = "-1"
}

resource "aws_vpc_security_group_egress_rule" "ecs_egress" {
  security_group_id = aws_security_group.ecs_node_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

# ---- ECS Task Security Group ----
# Only required for "awsvpc" network mode

resource "aws_security_group" "ecs_task_sg" {
  name        = "${var.ecs_cluster}-task-sg"
  description = "Security Group for ECS Tasks"
  vpc_id      = local.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "ecs_task_from_alb" {
  security_group_id            = aws_security_group.ecs_task_sg.id
  referenced_security_group_id = aws_security_group.alb_sg.id
  from_port                    = var.containerPort
  to_port                      = var.hostPort
  ip_protocol                  = "tcp"
}

resource "aws_vpc_security_group_egress_rule" "ecs_task_egress" {
  security_group_id = aws_security_group.ecs_task_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}

