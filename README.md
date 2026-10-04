# DevOps Bootcamp Final Project

This repository contains a small AWS-based infrastructure project built with Terraform and Ansible. It provisions a three-node EC2 environment: a public-facing web server, a private automation controller, and a private monitoring node running Prometheus and Grafana.

## Architecture

The deployment creates a VPC with:

- one public subnet for the web server
- one private subnet for the controller and monitoring node
- security groups for HTTP, SSH, and Node Exporter access
- an SSM-enabled IAM instance profile used by EC2 instances

The infrastructure is organized as follows:

- `terraform/` contains the Terraform infrastructure code
- `ansible/` contains the provisioning playbooks for the EC2 hosts
- generated inventory and state files are created during Terraform runs

## Repo structure

```text
.
├── ansible/
│   ├── ansible.cfg
│   ├── mon-compose.yaml
│   ├── mon-prometheus.yaml.j2
│   ├── playbook-ctrl.yaml
│   ├── playbook-mon.yaml
│   ├── playbook-web.yaml
│   └── requirements.yaml
├── terraform/
│   ├── ec2.tf
│   ├── inventory.ini.tftpl
│   ├── inventory.tf
│   ├── network.tf
│   ├── outputs.tf
│   ├── providers.tf
│   ├── security.tf
│   ├── userdata-ctrl.sh
│   ├── variables.tf
│   └── .terraform/
├── README.md
├── terraform.tfstate
└── .gitignore
```

## Components

### Webserver
- Public EC2 instance exposed on the internet
- Runs the application entry point and is reachable via SSH over the VPC network
- Includes Node Exporter for monitoring

### Controller (`ctrl`)
- Private EC2 instance used as the Ansible control node
- Validates connectivity to other servers and prepares the environment
- Clones the project repository and installs Ansible dependencies

### Monitoring (`mon`)
- Private EC2 instance running Docker-based Prometheus and Grafana
- Collects metrics from the web server and itself via Node Exporter
- Uses a Docker Compose configuration under `ansible/`

## Prerequisites

Before deploying, ensure the following are available:

- Terraform >= 1.15
- AWS CLI configured with valid credentials
- An AWS account with access to create VPC, EC2, IAM, and security resources
- SSH key available for the `afiq` key pair and the matching private key on your workstation
- Ansible installed locally if you plan to run playbooks outside the controller instance

## Deployment workflow

Start in the Terraform directory:

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

This creates the VPC, subnets, security groups, EC2 instances, and an Ansible inventory file. The Terraform configuration uses the AWS provider in `ap-southeast-1` and stores state in the S3 backend bucket `devops-bootcamp-terraform-afiq`.

After apply, the generated inventory file can be used with Ansible from the repo root:

```bash
cd ..
ansible-playbook -i terraform/inventory.ini ansible/playbook-web.yaml
ansible-playbook -i terraform/inventory.ini ansible/playbook-ctrl.yaml
ansible-playbook -i terraform/inventory.ini ansible/playbook-mon.yaml
```

## Useful outputs

Terraform outputs include:

- public IP of the web server
- private IPs of the controller and monitoring host
- SSM session commands for each instance

Example:

```bash
cd terraform
terraform output
```

## SSH and access

The generated inventory uses the `ubuntu` user and the SSH private key configured in `ansible/inventory.ini` / `terraform/inventory.ini.tftpl`.

For SSM access:

```bash
aws ssm start-session --target <instance-id> --region ap-southeast-1
```

## Monitoring

The monitoring host installs Prometheus and Grafana through Docker Compose. The configuration files live in `ansible/mon-prometheus.yaml.j2` and `ansible/mon-compose.yaml`.

## Notes

- The project targets AWS, not LocalStack.
- Default project metadata is tagged with:
  - `Project = "devops-bootcamp-final-afiq"`
  - `ManagedBy = "terraform"`
- The repository is focused on infrastructure provisioning and configuration automation rather than an application codebase.

## Cleanup

To remove the deployed infrastructure:

```bash
cd terraform
terraform destroy
```
