# AWS ECS Fargate Infrastructure (Test Application)

This repository contains the Terraform infrastructure code to provision a highly available, secure, and scalable environment on AWS ECS Fargate for a Java/Maven application.

## Infrastructure Architecture

The infrastructure is designed to be completely private and secure, following AWS best practices for VPC-only internal applications.

### Core Components Provisioned:

1.  **VPC Networking**: Utilizes an existing VPC (`test-vpc`) with 2 private subnets (for high availability) and 2 public subnets (for egress via NAT if required).
2.  **Internal ALB**: An Internal Application Load Balancer that handles HTTPS traffic using an ACM certificate for `test.wowcher.co.uk`.
3.  **Security Groups**:
    *   **ALB SG**: Restricted to internal ingress on HTTPS (Port 443).
    *   **ECS SG**: Restricted to only allow ingress from the ALB on the application port (8080).
4.  **ECR Repository**: A private Elastic Container Registry to store the application images.
5.  **ECS Cluster**: A logical grouping of Fargate services.
6.  **ECS Fargate Service**:
    *   **Task Definition**: Configures the container with 512 CPU and 1024 Memory.
    *   **Task Role**: IAM permissions for the application at runtime.
    *   **Execution Role**: Permissions for the ECS agent to pull images and fetch secrets.
7.  **Secrets Management**: Integration with AWS SSM Parameter Store for secure database credentials injection.
8.  **Auto-Scaling**: An AWS App Auto-Scaling policy that tracks average CPU utilization at 70%, scaling the service between 2 and 6 tasks automatically.

## Infrastructure Modules

The codebase is organized into reusable modules located in the `modules/` directory:

-   `network`: Fetches metadata for existing VPC and subnets.
-   `ecr`: Provisions the image repository.
-   `iam`: Manages ECS execution and task roles.
-   `alb`: Provisions the internal load balancer and security groups.
-   `ecs-cluster`: Defines the ECS Fargate cluster.
-   `ecs-service`: Provisions the task definition, service, and auto-scaling policies.

## Configuration & Usage

All configuration is centralized in the `infra-repo/terraform.tfvars` file.

### Required Manual Step:
Before applying the infrastructure, you must provide the ARN for your ACM certificate in `terraform.tfvars`:
```hcl
certificate_arn = "arn:aws:acm:region:account:certificate/..."
```

### Initializing and Applying:

1.  **Initialize Terraform**:
    ```bash
    cd infra-repo
    terraform init
    ```

2.  **Plan Infrastructure**:
    ```bash
    terraform plan
    ```

3.  **Apply Infrastructure**:
    ```bash
    terraform apply
    ```
