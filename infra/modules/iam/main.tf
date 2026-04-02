resource "aws_iam_role" "ecs_task_execution" {
  name = "ecsTaskExecutionRole-${var.project}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ecs-tasks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "execution_policy" {
  role       = aws_iam_role.ecs_task_execution.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy" "ssm_policy" {
  name = "${var.project}-ssm-policy"
  role = aws_iam_role.ecs_task_execution.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Action = [
        "ssm:GetParameters",
        "ssm:GetParameter"
      ]
      Resource = [
        "arn:aws:ssm:*:*:parameter/test/db_username",
        "arn:aws:ssm:*:*:parameter/test/db_password"
      ]
    }]
  })
}

resource "aws_iam_role" "ecs_task_role" {
  name = "${var.project}-ecs-task-role"
  assume_role_policy = aws_iam_role.ecs_task_execution.assume_role_policy 
}