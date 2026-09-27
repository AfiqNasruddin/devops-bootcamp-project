resource "local_file" "inventory" {
  filename = "inventory.ini"
  content = templatefile("inventory.ini.tftpl", {
    webserver_ip = module.webserver.private_ip
    //ctrl_ip      = module.ctrl.private_ip
    ctrl_id      = module.ctrl.id
    mon_ip       = module.mon.private_ip
  })
}
