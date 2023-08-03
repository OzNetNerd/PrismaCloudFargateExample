variable "name" {
  description = "Name prefix for resources on AWS"
}

variable "vpc_cidr_block" {
  description = "VPC CIDR block"
  type        = string
  default     = "10.0.0.0/16"
}

variable "private_subnets_cidrs" {
  description = "Four subnets for public hosts"
  type        = tuple([string, string, string, string])
  default     = ["10.0.0.0/19", "10.0.32.0/19", "10.0.64.0/19", "10.0.96.0/19"]
}

variable "public_subnets_cidrs" {
  description = "Four subnets for public hosts"
  type        = tuple([string, string, string, string])
  default     = ["10.0.128.0/19", "10.0.160.0/19", "10.0.192.0/19", "10.0.224.0/19"]
}

variable "container_name" {
  type        = string
  description = "Container name"
}

variable "container_image" {
  type        = string
  description = "Container image name"
}

variable "lb_http_ports" {
  description = "Loadbalancer HTTP ports"
  type        = map(any)
  default = {
    default_http = {
      type              = "forward"
      listener_port     = 80
      target_group_port = 80
    }
  }
}

variable "lb_https_ports" {
  description = "Loadbalancer HTTPS ports"
  type        = map(any)
  default = {
    default_http = {
      listener_port     = 443
      target_group_port = 443
    }
  }
}

variable "port_mappings" {
  description = "The port mappings to configure for the container. This is a list of maps. Each map should contain \"containerPort\", \"hostPort\", and \"protocol\", where \"protocol\" is one of \"tcp\" or \"udp\". If using containers in a task with the awsvpc or host network mode, the hostPort can either be left blank or set to the same value as the containerPort"
  type = list(object({
    containerPort = number
    hostPort      = number
    protocol      = string
  }))
  default = [
    {
      containerPort = 8080
      hostPort      = 8080
      protocol      = "tcp"
    }
  ]
}

variable "ecs_cluster_name" {
  type        = string
  description = "ECS cluster name"
}

variable "entrypoint" {
  type        = list(string)
  description = "The entry point that is passed to the container"
  default     = []
}

variable "command" {
  type        = list(string)
  description = "The command that is passed to the container"
  default     = []
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Resource tags"
}
