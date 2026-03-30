env     = "dev"
region  = "eu-west-2"

# -----------------------------------
# 🔹 EXISTING INFRASTRUCTURE (REPLACE WITH YOUR ARNS)
# -----------------------------------
cluster_name           = "test-cluster"
image_url              = "123456789012.dkr.ecr.eu-west-2.amazonaws.com/test-app:latest"
private_subnets        = ["subnet-0abc123", "subnet-0def456"]
app_security_group_ids = ["sg-0789ghi"]
target_group_arn       = "arn:aws:elasticloadbalancing:eu-west-2:123456789012:targetgroup/test-app-tg/abc123"
execution_role_arn     = "arn:aws:iam::123456789012:role/ecsTaskExecutionRole"
task_role_arn          = "arn:aws:iam::123456789012:role/ecsTaskRole"

# -----------------------------------
# 🔹 APPLICATION CONFIG
# -----------------------------------
desired_count = 2
cpu           = "256"
memory        = "512"