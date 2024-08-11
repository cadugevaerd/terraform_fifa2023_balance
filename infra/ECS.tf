module "ecs_cluster" {
  source = "terraform-aws-modules/ecs/aws//modules/cluster"

  cluster_name = "ecs-fargate-app"

  cluster_configuration = {
	execute_command_configuration = {
	  logging = "OVERRIDE"
	  log_configuration = {
		cloud_watch_log_group_name = "/aws/ecs/app-logs"
	  }
	}
  }

  fargate_capacity_providers = {
	FARGATE = {
	  default_capacity_provider_strategy = {
		weight = 100
	  }
	}
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "python-app"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
	execution_role_arn 			 = aws_iam_role.ecs_role.arn
  container_definitions    = jsonencode(
	[
		{
		"name" = "app_streamlit"
		"image" = "${aws_ecr_repository.ecr_app.repository_url}:latest"
		"cpu" = 256
		"memory" = 512
		"essential" = true
		"portMappings" = [
			{
				"containerPort" = 8501
				"hostPort" = 8501
			}
		]
		}
	]
)
}

resource "aws_ecs_service" "app_streamlit_service" {
  name            = "app-streamlit-service"
  cluster         = module.ecs_cluster.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 3

  load_balancer {
    target_group_arn = aws_lb_target_group.app_tg_ip.arn
    container_name   = "app_streamlit"
    container_port   = 8501
  }

	network_configuration {
		subnets = module.vpc.private_subnets
		assign_public_ip = false
		security_groups = [aws_security_group.privateNetwork_Allow_Traffic.id]
	}
	
	force_new_deployment = true

  triggers = {
    redeployment = plantimestamp()
  }
}