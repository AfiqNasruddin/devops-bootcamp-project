output "is_localstack" {
  value = data.aws_caller_identity.my_account.account_id == "000000000000"
}

output "webserver_id" {
  value = module.webserver.id
}

output "ctrl_id" {
  value = module.ctrl.id
}

output "mon_id" {
  value = module.mon.id
}

output "webserver_public_ip" {
  value = module.webserver.public_ip
}

output "ctrl_public_ip" {
  value = module.ctrl.public_ip
}

output "mon_public_ip" {
  value = module.mon.public_ip
}

output "web_private_ip" {
  value = module.webserver.private_ip
}

output "controller_private_ip" {
  value = module.ctrl.private_ip
}

output "monitoring_private_ip" {
  value = module.mon.private_ip
}

output "iam_role_name" {
  value = aws_iam_role.ssm.name
}

output "iam_instance_profile_name" {
  value = aws_iam_instance_profile.ssm.name
}
