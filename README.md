# Terraform AWS Infrastructure Assignment

## Overview

This project provisions the network and compute foundation for a web application on AWS using Terraform.

The infrastructure includes:

* Custom VPC
* Public and Private Subnets across two Availability Zones
* Internet Gateway
* NAT Gateway
* Route Tables
* Security Groups
* Application Load Balancer (ALB)
* Auto Scaling Group (ASG)
* Launch Template
* Remote Terraform Backend using Amazon S3
* State Locking using DynamoDB

---

## Architecture

```
                    Internet
                        │
                        ▼
              Application Load Balancer
                        │
                        ▼
               Target Group (HTTP)
                        │
                        ▼
            Auto Scaling Group (EC2)
                        │
        ┌───────────────┴───────────────┐
        │                               │
     Private Subnet 1              Private Subnet 2
        │                               │
        └───────────────┬───────────────┘
                        │
                    NAT Gateway
                        │
                 Internet Gateway
                        │
                        ▼
                       VPC
```

---

## Project Structure

```
terraform-assignment/
│
├── README.md
├── plan.txt
├── .gitignore
├── terraform.lock.hcl
│
├── .github/
│   └── workflows/
│       └── terraform-ci.yml
│
├── environments/
│   ├── dev/
│   └── prod/
│
└── modules/
    ├── vpc/
    ├── security-group/
    ├── alb/
    └── asg/
    
```

---

## Modules

### VPC Module

Creates:

* VPC
* Public Subnets
* Private Subnets
* Internet Gateway
* NAT Gateway
* Route Tables
* Route Table Associations

### Security Group Module

Creates:

* ALB Security Group
* EC2 Security Group

### ALB Module

Creates:

* Application Load Balancer
* Target Group
* HTTP Listener

### ASG Module

Creates:

* Launch Template
* Auto Scaling Group

---

## Remote Backend

Terraform state is stored remotely in Amazon S3.

State locking is implemented using DynamoDB to prevent concurrent Terraform operations.

---

## Environments

Two environments are provided:

* dev
* prod

Both environments reuse the same Terraform modules and differ only through variable values.

---

## Deployment

Initialize Terraform:

```bash
terraform init
```

Validate the configuration:

```bash
terraform validate
```

Review the execution plan:

```bash
terraform plan
```

Apply the infrastructure:

```bash
terraform apply
```

Destroy the infrastructure:

```bash
terraform destroy
```

---

## Stretch Goal

A GitHub Actions workflow has been added to automatically run Terraform checks on every Pull Request.

The workflow performs:

- terraform fmt -check
- terraform init
- terraform validate
- terraform plan

### Handling Infrastructure Drift

Infrastructure drift can occur when AWS resources are modified manually outside Terraform.

To handle drift:

- Regularly run `terraform plan` to detect unexpected changes.
- Use `terraform apply` to reconcile infrastructure with the desired state.
- Restrict manual changes using IAM policies.
- Ensure all infrastructure updates are performed through Terraform to keep the state consistent.


## Notes

* Terraform modules are reusable.
* Remote backend is configured using Amazon S3.
* State locking is configured using DynamoDB.
* Terraform state files are excluded from Git using `.gitignore`.
* A clean Terraform plan is included as `plan.txt`.
* Automatically posting the Terraform plan as a Pull Request comment is acknowledged as part of the stretch goal but has not been implemented in this assignment.

