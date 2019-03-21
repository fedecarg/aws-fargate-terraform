[
  {
    "name": "${resource_prefix}",
    "image": "${container_image}",
    "cpu": ${container_cpu},
    "memory": ${container_memory},
    "portMappings": [
      { "containerPort": ${container_port}, "hostPort": ${container_port}, "protocol": "tcp" }
    ],
    "essential": true,
    "environment": [],
    "mountPoints": [],
    "volumesFrom": []
  }
]
