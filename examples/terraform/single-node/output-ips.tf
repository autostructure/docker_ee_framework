# If the ip reporting below times out, set "wait_for_guest_net_timeout"
# to a value greater than the default of 5 minutes.
# You will find the setting in the vars file.

# output "workers-ip" {
#     value = "${vsphere_virtual_machine.docker_ucp_worker_nodes.*.default_ip_address}"
# }

output "nfs-ip" {
    value = "${vsphere_virtual_machine.nfs.default_ip_address}"
}
