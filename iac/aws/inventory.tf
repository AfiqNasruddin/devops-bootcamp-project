resource "local_file" "inventory" {
  filename = "inventory.ini"
  content = templatefile("inventory.ini.tftpl", {
    web_ip = module.web.public_ip
    ctrl_ip = module.ctrl.public_ip
    mon_ip = module.mon.public_ip
  })
}
