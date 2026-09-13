output "webserver_ip" { value = module.webserver.public_ip }
//output "ctrl_ip" { value = module.ctrl.public_ip }
output "web_private_ip" {
  value = module.web.private_ip
}

output "web_elastic_ip" {
  value = module.webserver.public_ip
}

output "controller_private_ip" {
  value = module.ctrl.private_ip
}

output "monitoring_private_ip" {
  value = module.mon.private_ip
}

output "ssm_command_1" {
  value = "aws ssm start-session --target ${module.webserver.id}"
}

output "ssm_command_2" {
  value = "aws ssm start-session --target ${module.ctrl.id}"
}

output "ssm_command_3" {
  value = "aws ssm start-session --target ${module.mon.id}"
}