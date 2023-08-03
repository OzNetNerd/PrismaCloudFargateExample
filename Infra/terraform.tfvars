name             = "fargate-demo"
container_name   = "fargate-demo"
container_image  = "<ACCOUNT_NUMBER>.dkr.ecr.<REGION>.amazonaws.com/fargate-app:latest"
ecs_cluster_name = "fargate-demo-cluster"
entrypoint       = ["python"]
command          = ["app.py"]
lb_https_ports   = {}