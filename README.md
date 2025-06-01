# AWS Threat Modelling App Deployment to AWS ECS with Terraform and Github Actions

This project deploys a containerised Node.js application to AWS ECS using Terraform and GitHub Actions. The setup is designed to be simple, repeatable, and scalable, removing the need for manual steps in the AWS Console.

---

## Overview

The application runs in a Docker container hosted on ECS Fargate. Infrastructure is defined using Terraform and deployed through automated workflows in GitHub Actions. DNS is handled through Route 53 with HTTPS enabled via ACM.

---

### Architecture Diagram:

![alt text](<Architecture Diagram.gif>)

---

### Local App Setup 💻

```bash
yarn install
yarn build
yarn global add serve
serve -s build
```
Then visit:

```bash
http://localhost:3000/workspaces/default/dashboard
```

Or use:

```bash
yarn global add serve
serve -s build
```

---

## Key Components

### Docker
- A `Dockerfile` in the root directory defines how the application is built into a container.

### Terraform
- ECS Fargate for hosting the container.
- Application Load Balancer for routing traffic.
- Route 53 for domain management.
- ACM for SSL certificates.
- Security groups to control access.
- VPC with public subnets, internet gateway, and NAT gateway.
- Remote state stored in an S3 bucket using native state locking.

### CI/CD
GitHub Actions handles:

- Building and scanning the Docker image.
- Pushing the image to Amazon ECR.
- Running Terraform plan and apply.
- Destroying infrastructure if needed.

---

## Directory Structure

./
├── app/
│ ├── Dockerfile
├── terraform/
│ ├── backend.tf
│ ├── main.tf
│ ├── provider.tf
│ ├── variables.tf
│ └── modules/
│ ├── alb/
│ ├── ecs/
│ ├── network/
│ └── route53/
└── .github/
└── workflows/
├── docker-build.yml
├── terraform-plan.yml
├── terraform-apply.yml
└── terraform-destroy.yml

---

## Deployment Workflow

### 1. Docker Build and Push
- Builds the Docker image.
- Runs a security scan using Trivy.
- Pushes the image to Amazon ECR.

### 2. Terraform Plan
- Runs `terraform init` and `terraform plan`.
- Validates the configuration using TFLint.
- Scans for security issues using Checkov.

### 3. Terraform Apply
- Applies the Terraform configuration to provision or update resources.
- Deploys the ECS service, ALB, Route 53 records, and ACM certificate.

### 4. Terraform Destroy
- Destroys all Terraform-managed infrastructure when no longer needed.

---

## How to Use

1. These workflows use **workflow dispatch**, so they are manually triggered from the "Actions" tab on GitHub.
2. Follow the logs in the Actions tab to monitor progress.
3. Once deployed, access the app via the configured domain.

## Here is a quick demonstration:

### Domain Page

![alt text](<Threat Modelling Homepage.png>)

### SSL Certificate

![alt text](<SSL Certificate.png>)

### Github Actions Docker Build

![alt text](<Docker Build.png>)

### Github Actions Terraform Plan

![alt text](<Terraform Plan.png>)

### Github Actions Terraform Apply

![alt text](<Terraform Apply.png>)

### Github Actions Terraform Destroy

![alt text](<Terraform Destroy.png>)