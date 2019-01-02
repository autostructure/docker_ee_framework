# Roles for remote-exec commands below...
# pp_role=docker_load_balancer
# pp_role=docker_ucp_leader
# pp_role=docker_ucp_manager
# pp_role=docker_ucp_worker
# pp_role=nfs_server

# # number of docker nodes (managers)...
# variable "cnt_managers" {
#   default=3
# }
#
# # number of docker nodes (workers)...
# variable "cnt_workers" {
#   default=4
# }
#
# # timeout for 'wait_for_guest_net_timeout' (in minutes)
# variable "timeout_minutes" {
#   default=20
# }

# In the format() function below, 03d is number of “zero” prefixes.
# e.g format(manager%01d,2) = manager02
# If we want more leading zeros, change the number in front of the 'd'.
# e.g. format(test%03d,4) = test004
#
# Removed this statement from the remote-exec
# systemctl restart network;
#
resource "vsphere_virtual_machine" "docker_ucp_manager_nodes" {
  count            = "${var.cnt_managers}"
  name             = "${format("manager%03d",count.index+1)}"
  resource_pool_id = "${vsphere_resource_pool.docker_ee_pool.id}"
  datastore_id     = "${data.vsphere_datastore.DS0.id}"

  num_cpus         = 4
  memory           = 8192
  guest_id         = "centos7_64Guest"

  wait_for_guest_net_timeout = "${var.timeout_minutes}"

  network_interface {
    network_id   = "${data.vsphere_network.network.id}"
    adapter_type = "${data.vsphere_virtual_machine.template.network_interface_types[0]}"
    #adapter_type = "e1000"
    #adapter_type = "vmxnet3"
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
        host_name = "${format("manager%03d",count.index+1)}"
        domain    = "autostructure.io"
      }
      network_interface {}
      dns_server_list = ["192.168.5.63","75.75.75.75","8.8.8.8"]
      ipv4_gateway    = "192.168.5.1"
    }
  }

  provisioner "remote-exec" {
    inline = [
      "/bin/curl -k https://master.autostructure.io:8140/packages/current/install.bash | sudo bash -s extension_requests:pp_role=docker_ucp_manager",
    ]

    connection {
      type     = "ssh"
      user     = "root"
      password = "password"
    }
  }
}

resource "vsphere_virtual_machine" "docker_ucp_worker_nodes" {
  count            = "${var.cnt_workers}"
  name             = "${format("worker%03d",count.index+1)}"
  resource_pool_id = "${vsphere_resource_pool.docker_ee_pool.id}"
  datastore_id     = "${data.vsphere_datastore.DS0.id}"

  num_cpus         = 4
  memory           = 4096
  guest_id         = "centos7_64Guest"

  wait_for_guest_net_timeout = "${var.timeout_minutes}"

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
        host_name = "${format("worker%03d",count.index+1)}"
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
