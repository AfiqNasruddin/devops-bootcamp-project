resource "local_file" "inventory" {
  filename = "inventory.ini"
  content = templatefile("inventory.ini.tftpl", {
    webserver_ip = module.webserver.public_ip
    ctrl_ip = module.ctrl.public_ip
    mon_ip = module.mon.public_ip
  })
}
