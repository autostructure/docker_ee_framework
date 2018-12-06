# docker_ucp_mount_nfs.pp
# Configure nfs on VM hosting a Docker worker node.
#
# The 'options =>' parameter's basic, file-system independent settings:
# - 'defaults' use default options: rw, suid, dev, exec, auto, nouser, and async.
# - 'noauto'   do not mount when "mount -a" is given (e.g., at boot time)
# - 'user'     allow a user to mount
# - 'owner'    allow device owner to mount
# - 'comment'  or x-<name> for use by fstab-maintaining programs
# - 'nofail'   do not report errors for this device if it does not exist.
# @source fstab(5) man page
#
# The 'target =>' parameter is set to '/etc/fstab' to mount the share permanently.
#
# The equivalent 'mount' command (w/o modifying fstab):
# $ mount -t nfs4 nfs.autostructure.io:/nfs-share/docker-workers /mnt/docker/app-share
#
# The nfs-client CLI command to test mounting...
# $ showmount -e <nfs-server-hostname-or-ip>
#
class docker_ucp::docker_ucp_mount_nfs(
  Array  $nfs_client_mount_parents,
  String $nfs_client_mount,
  String $nfs_host,
  String $nfs_server_mount,
) {

  package { 'nfs-utils':
    ensure   => present,
  }

  file { $nfs_client_mount_parents:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { $nfs_client_mount:
    ensure => directory,
    owner  => nobody,
    group  => nobody,
    mode   => '0777',
  }

  @@file { "${nfs_server_mount}/${::fqdn}":
    ensure => directory,
    owner  => nobody,
    group  => nobody,
    mode   => '0777',
    tag    => 'nfs_client',
  }

  @@file_line { '/etc/exports':
    ensure => present,
    path   => '/etc/exports',
    line   => "${nfs_server_mount}/${::fqdn} ${::fqdn}(rw,sync,no_root_squash)",
    tag    => 'nfs_client',
    notify => Service['nfs'],
  }

  mount { $nfs_client_mount:
    ensure  => 'mounted',
    device  => "${nfs_host}:${nfs_server_mount}/${::fqdn}",
    dump    => '0',
    fstype  => 'nfs4',
    options => 'defaults',
    pass    => '0',
    target  => '/etc/fstab',
  }
}
