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
├── .gitignore
├── plan.txt
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

## Notes

* Terraform modules are reusable.
* Remote backend is configured using Amazon S3.
* State locking is configured using DynamoDB.
* Terraform state files are excluded from Git using `.gitignore`.
* A clean Terraform plan is included as `plan.txt`.
