# Copilot instructions for this repository

## Project context
This repository contains Terraform infrastructure for a DevOps bootcamp final project. The code is split into two deployment targets:

- `iac/aws`: production-style AWS deployment using the AWS provider and an S3-backed Terraform state.
- `iac/localstack`: LocalStack-based emulation for local validation, with mocked AWS credentials and LocalStack endpoints.

The project is infrastructure-as-code only; there is no application code, package manager project, or automated test suite beyond Terraform validation and planning.

## Build, test, and lint commands
Use the Terraform CLI directly in the relevant module directory.

### Format
```bash
terraform fmt -recursive
```

### Validate a single module
```bash
terraform -chdir=iac/localstack init -backend=false
terraform -chdir=iac/localstack validate

terraform -chdir=iac/aws init
terraform -chdir=iac/aws validate
```

### Plan a single environment
```bash
terraform -chdir=iac/localstack plan
terraform -chdir=iac/aws plan
```

### Quick syntax check for a changed directory
```bash
terraform -chdir=iac/localstack validate
```

This repo does not define unit tests or language-specific lint tasks. The practical verification workflow is `fmt` + `validate` + `plan` for the affected Terraform directory.

## High-level architecture
The repository is organized around Terraform modules that provision a small EC2 network topology.

- `iac/localstack` and `iac/aws` mirror the same architecture but differ in provider configuration and backend strategy.
- `network.tf` creates the VPC, subnets, and route table configuration via `terraform-aws-modules/vpc/aws`.
- `security.tf` defines public and private security groups for HTTP, SSH, and Node Exporter access.
- `ec2.tf` provisions the EC2 instances (`webserver`, `ctrl`, `mon`) with fixed private IPs, key pairs, and IAM instance profiles.
- `iam.tf` configures the EC2 SSM assume-role policy and instance profile used by the instances.
- `inventory.tf` emits an Ansible inventory file (`inventory.ini`) from the created instance IPs; the LocalStack variant generates the inventory from `inventory.ini.tftpl`.
- `providers.tf` sets the provider version constraints and backend configuration. LocalStack uses a local state file; AWS uses an S3 backend.

The two environments are intentionally parallel: changes that affect networking, tagging, or instance layout should be kept consistent across both directories unless the behavior is intentionally environment-specific.

## Key conventions
- Keep all Terraform changes inside `iac/aws` or `iac/localstack`; do not create ad hoc infrastructure at the repository root.
- Maintain the same module structure across both environments. When changing variable names, module inputs, or default tag values, update both directories together.
- This project pins Terraform and provider versions explicitly:
  - `required_version = ">= 1.15"`
  - AWS provider version uses `~> 6.0`
  - the VPC and EC2 modules use `terraform-aws-modules/*` with a pinned major version
- LocalStack configuration is intentionally mock-based and not a real AWS setup. It uses test credentials and explicit LocalStack endpoints, so avoid treating those values as production defaults.
- Default project metadata is standardized as:
  - `Project = "devops-bootcamp-final-afiq"`
  - `ManagedBy = "terraform"`
- The repo relies on regional defaults such as `ap-southeast-1` and `ap-southeast-1a`; keep those conventions unless the environment specifically requires a change.
- When possible, prefer Terraform-managed resources and output values over hard-coded IPs or IDs when generating downstream artifacts like inventories.

## Operational notes
- The LocalStack environment is meant for local validation and experimentation; it assumes LocalStack is running and reachable at `http://localhost:4566`.
- The AWS environment expects an S3 bucket named `devops-bootcamp-terraform-afiq` for remote state and uses the `ap-southeast-1` region by default.
- The repo includes generated output artifacts (`inventory.ini`, `.pem` keys) from Terraform runs; do not treat them as source-of-truth configuration unless you are intentionally updating generated infrastructure outputs.
