resource "vsphere_virtual_machine" "nfs" {
  name             = "nfs001"
  resource_pool_id = "${vsphere_resource_pool.docker_ee_pool.id}"
  datastore_id     = "${data.vsphere_datastore.DS0.id}"
  num_cpus         = 2
  memory           = 8192
  guest_id         = "centos7_64Guest"

  wait_for_guest_net_timeout = "${var.timeout_minutes}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = 128
    thin_provisioned = true
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "nfs001"
        domain    = "autostructure.io"
      }
      network_interface {}
      dns_server_list = ["192.168.5.63","75.75.75.75","8.8.8.8"]
      ipv4_gateway    = "192.168.5.1"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "/bin/curl -k https://master.autostructure.io:8140/packages/current/install.bash | sudo bash -s extension_requests:pp_role=nfs_server",
    ]

    connection {
      type     = "ssh"
      user     = "root"
      password = "password"
    }
  }
}
