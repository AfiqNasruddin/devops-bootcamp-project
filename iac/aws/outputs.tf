output "webserver_ip" { value = module.webserver.public_ip }
//output "ctrl_ip" { value = module.ctrl.public_ip }

output "ssm_command_1" {
  value = "aws ssm start-session --target ${module.webserver.id}"
}

output "ssm_command_2" {
  value = "aws ssm start-session --target ${module.ctrl.id}"
}

output "ssm_command_3" {
  value = "aws ssm start-session --target ${module.mon.id}"
}