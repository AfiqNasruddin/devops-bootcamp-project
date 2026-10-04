resource "local_file" "inventory" {
  filename = "inventory.ini"
  content = templatefile("inventory.ini.tftpl", {
    webserver_ip = aws_instance.webserver.private_ip
    ctrl_ip      = aws_instance.ctrl.private_ip
    mon_ip       = aws_instance.mon.private_ip
  })
}
