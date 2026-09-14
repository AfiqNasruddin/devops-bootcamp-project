output "webserver_ip" { value = module.webserver.public_ip }
//output "ctrl_ip" { value = module.ctrl.public_ip }
output "web_private_ip" {
  value = module.webserver.private_ip
}

output "controller_private_ip" {
  value = module.ctrl.private_ip
}

output "monitoring_private_ip" {
  value = module.mon.private_ip
}

output "ssm_webserver" {
  value = "aws ssm start-session --target ${module.webserver.id}"
}

output "ssm_ctrl" {
  value = "aws ssm start-session --target ${module.ctrl.id}"
}

output "ssm_mon" {
  value = "aws ssm start-session --target ${module.mon.id}"
}