variable "project" {
  type        = string
  default     = "ecs-backend"
  description = "Project name"
}

variable "env" {
  default     = "development"
  description = "Environment for the infrastructure (development, staging, production)"
}

variable "region" {
  default     = "us-east-1"
  description = "AWS region for the infrastructure"
}

variable "instance_type" {
  default     = "t2.micro"
  description = "EC2 instance type"
}

variable "route53_zone_name" {
  type        = string
  default     = "zerodawndevops.com"
  description = "Name of Route53 zone for DNS record"
}

##############################################################################
# NAMES
# These names are used in the infrastructure as-is and should not be changed
# unless you want to recreate the entire infrastructure.

variable "ecr_repo" {
  type        = string
  default     = "health-check"
  description = "ECR repository name for the backend service"
}

variable "ecs_cluster" {
  type        = string
  default     = "ecs-cluster"
  description = "ECS cluster name"
}

variable "ecs_service" {
  type        = string
  default     = "ecs-service"
  description = "ECS service name"
}

variable "service-family" {
  type        = string
  default     = "service-family"
  description = "ECS service family"
}

variable "alb" {
  type        = string
  default     = "alb"
  description = "Application Load Balancer name"
}

variable "asg" {
  type        = string
  default     = "asg"
  description = "Auto Scaling Group name"
}

variable "target_group" {
  type        = string
  default     = "alb-target-group"
  description = "Application Load Balancer target group name"
}

variable "template_prefix" {
  type        = string
  default     = "ecs-backend"
  description = "Prefix for ECS task definition template"
}

##############################################################################
# Task and Container Configs
# Contains values for configuring the ECS task and container

variable "task_cpu" {
  type        = string
  default     = "512"
  description = "ECS task CPU units"
}

variable "task_memory" {
  type        = string
  default     = "1024"
  description = "ECS task memory units"
}

variable "task_network_mode" {
  type        = string
  default     = "awsvpc"
  description = "ECS task network mode"
}

variable "container_name" {
  type        = string
  default     = "health-check-backend"
  description = "ECS task container name"
}

variable "container_tag" {
  type        = string
  default     = "latest"
  description = "ECS task container tag"
}

variable "containerPort" {
  type        = number
  default     = 4000
  description = "ECS task container port"
}

variable "hostPort" {
  type        = number
  default     = 4000
  description = "ECS task container host port"
}

variable "container_cpu" {
  type        = string
  default     = "512"
  description = "ECS task container CPU units"
}

variable "container_memory" {
  type        = string
  default     = "1024"
  description = "ECS task container memory units"
}

##############################################################################
# Autoscaling Size

variable "min_capacity" {
  type        = string
  default     = "1"
  description = "Minimum capacity for the Auto Scaling Group"
}

variable "max_capacity" {
  type        = string
  default     = "3"
  description = "Maximum capacity for the Auto Scaling Group"
}

variable "desired_capacity" {
  type        = string
  default     = "2"
  description = "Desired capacity for the Auto Scaling Group"
}

##############################################################################
# Original Mapping

# variable "name" {
#   default = {
#     ecr_repo        = "health-check"
#     ecs_cluster     = "ecs-cluster"
#     service         = "ecs-service"
#     family          = "service-family"
#     alb             = "alb"
#     asg             = "asg"
#     target_group    = "alb-target-group"
#     template_prefix = "ecs-template"
#     project         = "health-check-backend"
#   }
#   description = <<-EOF
#     Names for resources.
#     (ecr_repo, ecs_cluster, service, family, alb, asg, target_group, template_prefix, project)
#   EOF
# }
#
# variable "vpc" {
#   default = {
#     cidr            = "10.0.0.0/16"
#     public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
#     private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
#     azs             = ["us-east-1a", "us-east-1b"]
#   }
#   description = <<-EOF
#     VPC configuration. Subnets and AZs are variable length lists.
#     (cidr, public_subnets[], private_subnets[], azs[])
#   EOF
# }
#
# variable "task" {
#   default = {
#     cpu          = 1024
#     memory       = 1024
#     network_mode = "awsvpc"
#   }
#   description = <<-EOF
#     Task configuration.
#     (cpu, memory, network_mode)
#   EOF
# }
#
# variable "container" {
#   default = {
#     name          = "health-check-backend"
#     image_tag     = "latest"
#     containerPort = 4000
#     hostPort      = 4000
#     cpu           = 512
#     memory        = 512
#   }
#   description = <<-EOF
#     Container configuration.
#     (name, image_tag, containerPort, hostPort, cpu, memory)
#   EOF
# }
#
# variable "size" {
#   default = {
#     min     = 1
#     max     = 2
#     desired = 1
#   }
#   description = <<-EOF
#     Desired/minimum/maximum capacity for ASG.
#     (min, max, desired)
#   EOF
# }

