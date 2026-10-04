# LocalStack Deployment

This folder contains the LocalStack version of the DevOps bootcamp infrastructure. It provisions an AWS-style network topology and EC2 resources locally through LocalStack instead of deploying them to AWS.

## Prerequisites

- Terraform `>= 1.15`
- LocalStack running and reachable at `http://localhost:4566`
- The LocalStack EC2 service enabled

Verify that LocalStack is available:

```bash
curl http://localhost:4566/_localstack/health
```

The Terraform configuration uses LocalStack's default credentials:

```text
Access key: test
Secret key: test
Region:     ap-southeast-1
```

## Folder structure

```text
localstack/
├── ansible/    # Optional Ansible playbooks and configuration
└── terraform/  # LocalStack Terraform configuration
```

Terraform uses local state in `terraform/terraform.tfstate`; it does not use the production S3 backend.

## Deploy

Run Terraform from this folder:

```bash
cd localstack/terraform

terraform init
terraform validate
terraform plan
terraform apply
```

To apply without an interactive approval prompt:

```bash
terraform apply -auto-approve
```

Terraform creates:

- A VPC with public and private subnets
- Internet gateway and route tables
- Public and private security groups
- Three EC2 instances: `webserver`, `ctrl`, and `mon`
- An IAM role and instance profile
- `terraform/inventory.ini` for the Ansible inventory

The configuration disables NAT Gateway and Elastic IP creation because they are unnecessary for this local validation target.

## Configuration

The main variables and their defaults are:

| Variable | Default | Purpose |
|---|---|---|
| `region` | `ap-southeast-1` | LocalStack AWS region |
| `az` | `ap-southeast-1a` | Availability zone |
| `localstack_endpoint` | `http://localhost:4566` | LocalStack API endpoint |
| `ami_id` | `ami-1e749f67` | AMI registered in LocalStack |
| `instance_type` | `t3.micro` | EC2 instance type |
| `cidr_block_my_vpc` | `10.0.0.0/24` | VPC CIDR |
| `subnet_cidr_block_public` | `10.0.0.0/25` | Public subnet CIDR |
| `subnet_cidr_block_private` | `10.0.0.128/25` | Private subnet CIDR |

Override a variable at plan or apply time:

```bash
terraform apply -var="ami_id=ami-your-localstack-ami-id"
```

The default AMI is available in the standard LocalStack image catalog. If it is not present in your LocalStack setup, register an AMI and pass its ID using `-var="ami_id=..."`.

## Outputs and inventory

After deployment, view the Terraform outputs:

```bash
terraform output
```

The outputs include the private IP addresses for all three instances, the webserver public IP assigned by LocalStack, and the IAM instance profile name.

Terraform also generates:

```text
terraform/inventory.ini
```

The inventory uses the private IP addresses and can be consumed by the playbooks under `ansible/`. LocalStack EC2 resources are API-emulated resources; they do not automatically provide reachable Ubuntu virtual machines or SSH daemons. Use the inventory with an execution environment that supplies the corresponding hosts and networking.

## Validate and clean up

Check that the deployed resources match the configuration:

```bash
terraform plan
```

Remove the LocalStack resources:

```bash
terraform destroy
```

`terraform destroy` removes resources from LocalStack and leaves the Terraform configuration intact.
