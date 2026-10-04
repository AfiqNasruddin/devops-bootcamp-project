output "webserver_public_ip" {
  value = aws_instance.webserver.public_ip
}
output "web_private_ip" {
  value = aws_instance.webserver.private_ip
}
output "controller_private_ip" {
  value = aws_instance.ctrl.private_ip
}
output "monitoring_private_ip" {
  value = aws_instance.mon.private_ip
}
output "iam_instance_profile_name" {
  value = aws_iam_instance_profile.ec2.name
}
