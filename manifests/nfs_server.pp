# nfs_server.pp
#
# The nfs-client CLI command to test mounting...
# $ showmount -e <nfs-server-hostname-or-ip>
#

# Class before moving to a single shared directory.
# Below (and in docker_ucp_mount_nfs.pp) are
# exported File & File_line resources...

class docker_ucp::nfs_server(
  Array  $nfs_server_mount_parents,
  String $nfs_server_mount,
) {

  package { 'nfs-utils':
    ensure   => present,
  }

  file { $nfs_server_mount_parents:
    ensure => directory,
    owner  => root,
    group  => root,
    mode   => '0755',
  }

  file { $nfs_server_mount:
    ensure => directory,
    owner  => nobody,
    group  => nobody,
    mode   => '0777',
  }

  # Is portmap replaced by 'nfs-idmapd.service'?
  # Didn't need portmap (using CentOS 7),
  # it wasn't even installed.
  # So, it's commented out...

  # # /etc/init.d/portmap start
  # service { 'portmap':
  #   ensure => running,
  #   enable => true,
  # }

  file_line { '/etc/exports - add domain to share config':
    ensure => present,
    path   => '/etc/exports',
    line   => "${nfs_server_mount} *.${::domain}(rw,sync,no_root_squash)",
    notify => Service['nfs'],
  }

  # /etc/init.d/nfs start
  service { 'nfs':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    restart    => 'systemctl restart nfs',
  }
}
