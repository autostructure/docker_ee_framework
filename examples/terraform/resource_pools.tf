resource "vsphere_resource_pool" "docker_ee_pool" {
  name                    = "docker_ee_pool"
  parent_resource_pool_id = "${data.vsphere_host.host.resource_pool_id}"
}
