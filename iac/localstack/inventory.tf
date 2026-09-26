resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"
  content = templatefile("${path.module}/inventory.ini.tftpl", {
    webserver_ip     = module.webserver.public_ip
    ctrl_ip          = module.ctrl.public_ip
    mon_ip           = module.mon.public_ip
    private_key_path = "${path.module}/localstack-key.pem"
  })
}
