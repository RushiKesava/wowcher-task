# AWS ECS Infrastructure Deployment (Test Application)

This repository contains the Terraform configuration and CI/CD pipeline to deploy a Java/Maven application (the "test" app) to **AWS ECS Fargate**. The infrastructure is designed for high availability, security, and scalability, leveraging existing network components.

## 🏗️ Architecture Overview

The deployment utilizes the following AWS services:
- **ECS Fargate**: Serverless container execution.
- **Internal ALB**: An internal-only Application Load Balancer for secure VPC-only traffic.
- **IAM Roles**: Least-privilege roles for Task Execution (logging, ECR pull, SSM access) and Task (application permissions).
- **Security Groups**: Multi-tier security allowing traffic only on required ports (443 for ALB, 8080 for ECS).
- **SSM Parameter Store**: Secure management of application secrets (e.g., `db_username`, `db_password`).
- **Auto Scaling**: Target tracking policy to maintain average CPU utilization at 70%.

## 📂 Repository Structure

```text
.
├── .gitlab-ci.yml             # GitLab CI/CD pipeline definition
├── ecs-deploy/                # Root Terraform directory
│   ├── main.tf                # Main infrastructure orchestration
│   ├── variables.tf           # Root variable definitions
│   ├── output.tf              # Infrastructure outputs
│   ├── envs/                  # Environment-specific configuration
│   │   ├── dev.tfvars         # Development environment values
│   │   ├── stage.tfvars       # Staging environment values
│   │   └── prod.tfvars        # Production environment values
│   └── modules/
│       └── ecs-service/       # Reusable ECS Service & Task module
└── README.md                  # This file
```

## 🚀 Getting Started

### 1. Prerequisites
Ensure you have the following pre-created in your AWS account:
- **VPC** (e.g., `test-vpc`) with at least 2 private and 2 public subnets.
- **SSL Certificate** in ACM (e.g., `test-cert`) for the domain `test.wowcher.co.uk`.
- **ECR Repository** containing your Docker image.
- **S3 Bucket & DynamoDB Table** for Terraform remote state and locking (configured in `.gitlab-ci.yml`).

### 2. Configure Environment Variables
Update the files in `ecs-deploy/envs/` with your specific AWS resource IDs:
- `cluster_name`: Name of your existing ECS Cluster.
- `private_subnets`: List of private subnet IDs.
- `app_security_group_ids`: Security group(s) for the ECS tasks.
- `target_group_arn`: ARN of the ALB target group for the service.
- `execution_role_arn`: ARN for the ECS Task Execution Role.

### 3. Setup Secrets
The application expects the following parameters in **AWS SSM Parameter Store**:
- `/[env]/db_username` (String)
- `/[env]/db_password` (SecureString)

Terraform will automatically link these parameters to the container's environment variables (`DB_USERNAME` and `DB_PASSWORD`).

## 🔄 CI/CD Pipeline

The GitLab CI/CD pipeline (`.gitlab-ci.yml`) handles the deployment across three environments:

1. **Development (`dev`)**: Triggered automatically on every push to the `main` branch.
2. **Staging (`stage`)**: Manual trigger after successful development deployment.
3. **Production (`prod`)**: Manual trigger for final deployment.

### Required GitLab CI/CD Variables:
- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION` (e.g., `eu-west-2`)
- `AWS_ACCOUNT_ID`

## 📊 Monitoring & Scaling

- **Logs**: Container logs are streamed to **CloudWatch Logs** under the group `/ecs/[service-name]`.
- **Scaling**: The service is configured with an **Auto Scaling policy** that monitors CPU utilization. If average CPU exceeds 70%, ECS will automatically launch additional tasks (up to a max of 10).

## 🛡️ Security Best Practices

- **Internal Access**: The ALB is internal-only, ensuring the app is never exposed to the public internet directly.
- **Restricted Traffic**: The ECS Security Group only accepts traffic on port 8080 from the ALB's Security Group.
- **Least Privilege**: IAM roles are scoped to only allow necessary actions like pulling from ECR and reading specific SSM parameters.
