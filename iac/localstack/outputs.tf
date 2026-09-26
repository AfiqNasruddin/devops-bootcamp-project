output "is_localstack" {
  description = "Whether this deployment is connected to LocalStack."
  value       = data.aws_caller_identity.my_account.account_id == "000000000000"
}

output "environment_summary" {
  description = "High-level details for the LocalStack deployment."
  value = {
    environment       = "localstack"
    region            = var.aws_region
    availability_zone = var.az
    vpc_id            = module.my_vpc.vpc_id
    cidr              = var.cidr_block_my_vpc
  }
}

output "instances" {
  description = "Instance identifiers and addresses for the LocalStack EC2 emulation."
  value = {
    webserver = {
      id         = module.webserver.id
      private_ip = module.webserver.private_ip
      public_ip  = module.webserver.public_ip
      subnet     = "public"
    }
    ctrl = {
      id         = module.ctrl.id
      private_ip = module.ctrl.private_ip
      public_ip  = module.ctrl.public_ip
      subnet     = "private"
    }
    mon = {
      id         = module.mon.id
      private_ip = module.mon.private_ip
      public_ip  = module.mon.public_ip
      subnet     = "private"
    }
  }
}

output "network" {
  description = "VPC, subnet, route table, and security group identifiers."
  value = {
    vpc_id = module.my_vpc.vpc_id
    subnets = {
      public  = module.my_vpc.public_subnets[0]
      private = module.my_vpc.private_subnets[0]
    }
    route_tables = {
      public  = module.my_vpc.public_route_table_ids[0]
      private = module.my_vpc.private_route_table_ids[0]
    }
    security_groups = {
      public  = module.public_sg.id
      private = module.private_sg.id
    }
  }
}

output "ssh_commands" {
  description = "SSH commands for connecting to the emulated instances from the host."
  value = {
    webserver = "ssh -i ${path.module}/localstack-key.pem root@${module.webserver.public_ip}"
    ctrl      = "ssh -i ${path.module}/localstack-key.pem root@${module.ctrl.public_ip}"
    mon       = "ssh -i ${path.module}/localstack-key.pem root@${module.mon.public_ip}"
  }
}

output "ansible_commands" {
  description = "Commands for validating and configuring the emulated instances with Ansible."
  value = {
    ping = "ansible -i ${path.module}/inventory.ini all -m ping"
    ctrl = "ansible-playbook -i ${path.module}/inventory.ini ${path.module}/playbook-ctrl.yaml"
    mon  = "ansible-playbook -i ${path.module}/inventory.ini ${path.module}/playbook-mon.yaml"
    web  = "ansible-playbook -i ${path.module}/inventory.ini ${path.module}/playbook-web.yaml"
  }
}

output "webserver_id" {
  description = "The LocalStack EC2 instance ID for the webserver."
  value       = module.webserver.id
}

output "ctrl_id" {
  description = "The LocalStack EC2 instance ID for the Ansible controller."
  value       = module.ctrl.id
}

output "mon_id" {
  description = "The LocalStack EC2 instance ID for the monitoring instance."
  value       = module.mon.id
}

output "webserver_public_ip" {
  description = "The LocalStack-reachable address for the webserver."
  value       = module.webserver.public_ip
}

output "ctrl_public_ip" {
  description = "The LocalStack-reachable address for the controller."
  value       = module.ctrl.public_ip
}

output "mon_public_ip" {
  description = "The LocalStack-reachable address for the monitoring instance."
  value       = module.mon.public_ip
}

output "web_private_ip" {
  description = "The private VPC address assigned to the webserver."
  value       = module.webserver.private_ip
}

output "controller_private_ip" {
  description = "The private VPC address assigned to the controller."
  value       = module.ctrl.private_ip
}

output "monitoring_private_ip" {
  description = "The private VPC address assigned to the monitoring instance."
  value       = module.mon.private_ip
}

output "iam_role_name" {
  description = "The IAM role attached to the emulated EC2 instances."
  value       = aws_iam_role.ssm.name
}

output "iam_instance_profile_name" {
  description = "The IAM instance profile attached to the emulated EC2 instances."
  value       = aws_iam_instance_profile.ssm.name
}
