resource "aws_iam_role" "ecs_role" {
  name = "ecs_role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
  "Version": "2012-10-17", 
  "Statement": [ 
    {
      "Sid": "AllowAccessToECSForInfrastructureManagement", 
      "Effect": "Allow", 
      "Principal": {
        "Service": ["ecs.amazonaws.com" ,"ecs-tasks.amazonaws.com"]
      }, 
      "Action": "sts:AssumeRole" 
    } 
  ] 
})
}

resource "aws_iam_role_policy" "ECS_role_policy" {
  name = "ECS_role_policy"
  role = aws_iam_role.ecs_role.id

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "ecs:*",
                "ecr:Get*",
                "ecr:Batch*",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "*"
        }
    ]
})
}

resource "aws_iam_instance_profile" "profile_ecs" {
  name = "profile_ecs"
  role = aws_iam_role.ecs_role.name
}