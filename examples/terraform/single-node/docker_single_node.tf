# Change hostname for docker_ucp_worker_nodes in 2 places.

resource "vsphere_virtual_machine" "docker_ucp_worker_nodes" {
  name             = "worker002"
  resource_pool_id = "${vsphere_resource_pool.docker_ee_pool.id}"
  datastore_id     = "${data.vsphere_datastore.DS0.id}"

  num_cpus         = 4
  memory           = 4096
  guest_id         = "centos7_64Guest"

  wait_for_guest_net_timeout = 20

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
  }

  disk {
    label            = "disk0"
    size             = 16
    thin_provisioned = true
  }

  clone {
    template_uuid = "${data.vsphere_virtual_machine.template.id}"

    customize {
      linux_options {
        host_name = "worker002"
        domain    = "autostructure.io"
      }
      network_interface {}
      dns_server_list = ["192.168.5.63","75.75.75.75","8.8.8.8"]
      ipv4_gateway    = "192.168.5.1"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "/bin/curl -k https://master.autostructure.io:8140/packages/current/install.bash | sudo bash -s extension_requests:pp_role=docker_ucp_worker",
    ]

    connection {
      type     = "ssh"
      user     = "root"
      password = "password"
    }
  }
}
