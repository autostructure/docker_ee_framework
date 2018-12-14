provider "vsphere" {
  user           = "administrator@vsphere.autostructure.io"
  password       = "MTV7-whipper"
  vsphere_server = "192.168.5.64"

  # If you have a self-signed cert
  allow_unverified_ssl = true
}

data "vsphere_datacenter" "dc" {
  name = "Datacenter"
}

data "vsphere_datastore" "Bitbucket" {
  name          = "Bitbucket"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "DS0" {
  name          = "DS0"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "DS1" {
  name          = "DS1"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_datastore" "DS2" {
  name          = "DS2"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "host" {
  name          = "192.168.5.60"                            # "cluster1/Resources"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_host" "host1" {
  name          = "192.168.5.60"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_network" "network" {
  name          = "VM Network"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}

data "vsphere_virtual_machine" "template" {
  name          = "CentOS"
  datacenter_id = "${data.vsphere_datacenter.dc.id}"
}
