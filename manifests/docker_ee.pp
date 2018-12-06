# docker_ee.pp
# Installs the Docker EE on a virtual machine.
#
class docker_ucp::docker_ee(
  Stdlib::Httpurl $docker_ee_url,
  Stdlib::Httpurl $docker_ee_key_source,
) {

  file { '/var/lib/docker':
    ensure => directory,
  }

  # NITC users 'serverbuild' for UID 1000. That conflicts with the 'jenkins' user that the jenkins container tries to use.
  # Probably not a good idea to remove serverbuild. Not sure what it is used for.
  # So that is why we are adding 'serverbuild' to the docker group
  user { 'serverbuild':
    ensure => present,
    gid    => 1000,
    groups => ['docker'],
    shell  => '/bin/bash',
    uid    => 1000,
  }

  mount { '/var/lib/docker':
    ensure  => 'mounted',
    device  => '/dev/appVG/appLV',
    fstype  => 'xfs',
    options => 'defaults',
    target  => '/etc/fstab',
  }

  class { '::docker':
    docker_ee                 => true,
    docker_ee_source_location => $docker_ee_url,
    docker_ee_key_source      => $docker_ee_key_source,
  }

  yumrepo { 'docker':
    ensure => 'absent',
  }
}
